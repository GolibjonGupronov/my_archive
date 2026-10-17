import 'package:my_archive/features/story/domain/entities/story_action_entity.dart';

enum StoryFileType {
  none,
  image,
  video;

  static StoryFileType getObj(String key) => switch (key) {
        'video' => StoryFileType.video,
        'image' => StoryFileType.image,
        _ => StoryFileType.none,
      };

  String get key => switch (this) {
        StoryFileType.video => 'video',
        StoryFileType.image => 'image',
        StoryFileType.none => '',
      };
}

class StoryEntity {
  final int id;
  final String title;
  final String thumbnail;
  final String resourceData;
  final StoryFileType resourceType;
  final StoryActionEntity? action;
  bool isRead;

  StoryEntity({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.resourceData,
    required this.resourceType,
    required this.action,
    required this.isRead,
  });
}
