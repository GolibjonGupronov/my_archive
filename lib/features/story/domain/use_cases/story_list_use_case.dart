import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/story/domain/entities/story_entity.dart';
import 'package:my_archive/features/story/domain/repositories/story_repository.dart';

class StoryListUseCase extends UseCase<List<StoryEntity>, NoParams>{
  final StoryRepository repository;

  StoryListUseCase({required this.repository});
  @override
  Future<Either<Failure, List<StoryEntity>>> callUseCase(NoParams params) async => await repository.storyList();

}