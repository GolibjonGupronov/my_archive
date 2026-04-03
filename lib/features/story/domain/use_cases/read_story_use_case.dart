import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/story/domain/repositories/story_repository.dart';

class ReadStoryUseCase extends UseCase<bool, int> {
  final StoryRepository repository;

  ReadStoryUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> callUseCase(int params) async => await repository.readStory(params);
}
