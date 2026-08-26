import 'package:my_archive/features/story/data/models/story_model.dart';

abstract class StoryDataSource {
  Future<List<StoryModel>> storyList();

  Future<bool> readStory(int params);
}
