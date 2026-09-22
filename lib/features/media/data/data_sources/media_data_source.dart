import 'package:my_archive/features/media/data/models/media_model.dart';

abstract class MediaDataSource {
  Future<List<MediaModel>> getMedia(String params);
}
