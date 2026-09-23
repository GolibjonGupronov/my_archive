import 'package:my_archive/core/enums/common.dart';
import 'package:my_archive/features/media/domain/entities/media_entity.dart';

class MediaModel extends MediaEntity {
  MediaModel({
    required super.id,
    required super.title,
    required super.thumbnail,
    required super.type,
    required super.mediaUrl,
  });

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return MediaModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      type: MediaType.getObj(json['type'] ?? ''),
      mediaUrl: json['media_url'] ?? '',
    );
  }
}
