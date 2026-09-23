import 'package:my_archive/core/enums/common.dart';

class MediaEntity {
  final String id;
  final String title;
  final String thumbnail;
  final MediaType type;
  final String mediaUrl;

  const MediaEntity({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.type,
    required this.mediaUrl,
  });
}
