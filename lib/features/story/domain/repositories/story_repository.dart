import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/story/domain/entities/story_entity.dart';

abstract class StoryRepository {
  Future<Either<Failure, List<StoryEntity>>> storyList();
}
