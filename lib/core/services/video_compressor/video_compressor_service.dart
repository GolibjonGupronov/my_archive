import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';
import 'package:my_archive/core/exports/core_exports.dart';
import 'package:my_archive/core/services/path_service.dart';
import 'package:my_archive/core/services/video_compressor/video_compress_config.dart';

class VideoCompressorService {
  final Dio dio;

  const VideoCompressorService({required this.dio});

  Future<String> prepareFromUrl(String url, {VideoCompressConfig config = const VideoCompressConfig()}) async {
    final cachedPath = await _cachedPathFor(url, config);
    if (await _existsAndNotEmpty(cachedPath)) {
      logger('GGQ => VideoCompressor cache hit: $cachedPath');
      return cachedPath;
    }

    final rawPath = await _downloadToTemp(url);
    try {
      await _runCompress(inputPath: rawPath, outputPath: cachedPath, config: config);
      return cachedPath;
    } finally {
      await _safeDelete(rawPath);
    }
  }

  Future<String> prepareFromFile(String inputPath,
      {VideoCompressConfig config = const VideoCompressConfig(), String? outputPath}) async {
    final inputFile = File(inputPath);
    if (!await inputFile.exists()) {
      throw const VideoCompressException('Manba video fayl topilmadi');
    }

    final resolvedOutputPath = outputPath ?? await _generateOutputPath();
    await _runCompress(inputPath: inputPath, outputPath: resolvedOutputPath, config: config);
    return resolvedOutputPath;
  }

  Future<void> _runCompress({required String inputPath, required String outputPath, required VideoCompressConfig config}) async {
    final command = '-y -i "$inputPath" '
        '-c:v libx264 -profile:v ${config.profile} -level ${config.level} '
        '-vf "${config.toFfmpegVideoFilter()}" '
        '-r ${config.fps} -crf ${config.crf} -preset ${config.preset} -pix_fmt yuv420p '
        '-c:a aac -b:a ${config.audioBitrateKbps}k '
        '-movflags +faststart '
        '"$outputPath"';

    logger('GGQ => VideoCompressor start: $command');

    final session = await FFmpegKit.execute(command);
    final returnCode = await session.getReturnCode();

    if (!ReturnCode.isSuccess(returnCode)) {
      final logs = await session.getAllLogsAsString();
      await _safeDelete(outputPath);
      throw VideoCompressException('FFmpeg xatosi (code: $returnCode): $logs');
    }
  }

  Future<String> _downloadToTemp(String url) async {
    final dir = await PathService.videosDir;
    final rawPath = '${dir.path}/vc_raw_${DateTime.now().microsecondsSinceEpoch}.mp4';

    logger('GGQ => VideoCompressor downloading: $url');

    try {
      await dio.download(url, rawPath);
    } on DioException catch (e) {
      throw VideoCompressException('Videoni yuklab olishda xatolik: ${e.message}');
    }

    return rawPath;
  }

  Future<String> _cachedPathFor(String url, VideoCompressConfig config) async {
    final dir = await PathService.videosDir;
    final hash = sha256.convert(utf8.encode('$url|${config.cacheKey}')).toString();
    return '${dir.path}/vc_cache_$hash.mp4';
  }

  Future<String> _generateOutputPath() async {
    final dir = await PathService.videosDir;
    return '${dir.path}/vc_out_${DateTime.now().microsecondsSinceEpoch}.mp4';
  }

  Future<bool> _existsAndNotEmpty(String path) async {
    final file = File(path);
    return await file.exists() && await file.length() > 0;
  }

  Future<void> _safeDelete(String path) async {
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }

  Future<void> clearFile(String path) => _safeDelete(path);

  Future<void> clearAllCache() async {
    final dir = await PathService.videosDir;
    if (!await dir.exists()) return;

    final files = dir.listSync().where((f) {
      final name = f.uri.pathSegments.last;
      return name.startsWith('vc_cache_') || name.startsWith('vc_raw_') || name.startsWith('vc_out_');
    });

    for (final f in files) {
      try {
        await f.delete();
      } catch (_) {}
    }
  }
}

class VideoCompressException implements Exception {
  final String message;

  const VideoCompressException(this.message);

  @override
  String toString() => 'VideoCompressException: $message';
}
