import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/story/data/data_sources/story_data_source.dart';
import 'package:my_archive/features/story/data/repositories/story_repository_impl.dart';
import 'package:my_archive/features/story/domain/repositories/story_repository.dart';
import 'package:my_archive/features/story/domain/use_cases/read_story_use_case.dart';
import 'package:my_archive/features/story/domain/use_cases/story_list_use_case.dart';

void initStoryInjection() {
  sl.registerSingleton<StoryDataSource>(StoryDataSourceImpl(dio: sl()));
  sl.registerSingleton<StoryRepository>(StoryRepositoryImpl(storyDataSource: sl()));
  sl.registerSingleton<StoryListUseCase>(StoryListUseCase(repository: sl()));
  sl.registerSingleton<ReadStoryUseCase>(ReadStoryUseCase(repository: sl()));
}
