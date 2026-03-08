import 'package:my_archive/features/story/domain/entities/story_entity.dart';

class StoryPageArgs {
  final List<StoryEntity> storyList;
  final int activeIndex;
  final Function(StoryEntity item) itemCheck;

  StoryPageArgs({
    required this.storyList,
    required this.activeIndex,
    required this.itemCheck,
  });
}
