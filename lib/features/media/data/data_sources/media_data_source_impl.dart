import 'package:dio/dio.dart';
import 'package:my_archive/features/media/data/data_sources/media_data_source.dart';
import 'package:my_archive/features/media/data/models/media_model.dart';

class MediaDataSourceImpl extends MediaDataSource {
  final Dio dio;

  MediaDataSourceImpl({required this.dio});

  @override
  Future<List<MediaModel>> getMedia(String params) {
    // TODO: implement getMedia
    throw UnimplementedError();
  }
}
