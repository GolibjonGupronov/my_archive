import 'dart:io';

import 'package:path_provider/path_provider.dart';

class PathService {
  static final Map<String, Directory> _cache = {};

  static Future<Directory> _getOrCreateDir(String folderName) async {
    if (_cache.containsKey(folderName)) {
      return _cache[folderName]!;
    }

    final baseDir = await getApplicationDocumentsDirectory();
    final dir = Directory("${baseDir.path}/$folderName");

    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    _cache[folderName] = dir;
    return dir;
  }

  static Future<Directory> get videosDir => _getOrCreateDir("videos");

  static Future<Directory> get audiosDir => _getOrCreateDir("audios");

  static Future<Directory> get imagesDir => _getOrCreateDir("images");

  static Future<void> _clearDirContents(Directory dir) async {
    if (!await dir.exists()) return;

    await for (final entity in dir.list()) {
      try {
        if (entity is Directory) {
          await entity.delete(recursive: true);
        } else {
          await entity.delete();
        }
      } catch (_) {}
    }
  }

  static Future<void> clearVideos() async {
    final dir = await videosDir;
    await _clearDirContents(dir);
  }

  static Future<void> clearAudios() async {
    final dir = await audiosDir;
    await _clearDirContents(dir);
  }

  static Future<void> clearImages() async {
    final dir = await imagesDir;
    await _clearDirContents(dir);
  }

  static Future<void> clearAll() async {
    await Future.wait([
      clearVideos(),
      clearAudios(),
      clearImages(),
    ]);
  }
}