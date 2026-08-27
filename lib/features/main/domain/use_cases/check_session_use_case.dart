import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/main/domain/repositories/main_repository.dart';

class CheckSessionUseCase extends UseCase<bool, NoParams> {
  final MainRepository repository;

  CheckSessionUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> callUseCase(NoParams params) async => await repository.checkSession();
}
