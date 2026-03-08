import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/story/data/data_sources/story_data_source.dart';
import 'package:my_archive/features/story/domain/entities/story_entity.dart';
import 'package:my_archive/features/story/domain/repositories/story_repository.dart';

class StoryRepositoryImpl with SafeCaller implements StoryRepository {
  final StoryDataSource storyDataSource;

  StoryRepositoryImpl({required this.storyDataSource});

  @override
  Future<Either<Failure, List<StoryEntity>>> storyList() {
    return safeCall(() async => await storyDataSource.storyList());
  }
}
