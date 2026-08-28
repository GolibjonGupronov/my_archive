import 'package:my_archive/core/exports/core_exports.dart';
import 'package:my_archive/features/main/domain/repositories/main_repository.dart';

class WatchSessionUseCase extends UseCase<Stream<bool>, NoParams> {
  final MainRepository repository;

  WatchSessionUseCase({required this.repository});

  @override
  Future<Either<Failure, Stream<bool>>> callUseCase(NoParams params) async => await repository.watchSession();
}
