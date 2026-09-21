import 'package:my_archive/core/services/video_compressor/video_compress_config.dart';
import 'package:my_archive/core/services/video_compressor/video_compressor_service.dart';

class PrepareStoryVideoUseCase {
  final VideoCompressorService compressorService;

  const PrepareStoryVideoUseCase({required this.compressorService});

  Future<String> callUseCase(String videoUrl) => compressorService.prepareFromUrl(videoUrl, config: VideoCompressConfig.compatible());
}
