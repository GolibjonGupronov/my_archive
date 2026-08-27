import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/story/domain/entities/story_action_entity.dart';

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
