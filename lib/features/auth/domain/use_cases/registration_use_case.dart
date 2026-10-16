import 'package:my_archive/core/exports/domain_exports.dart';
import 'package:my_archive/features/auth/domain/repositories/auth_repository.dart';

class RegistrationUseCase extends UseCase<bool, RegistrationParams> {
  final AuthRepository repository;

  RegistrationUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> callUseCase(RegistrationParams params) => repository.registration(params);
}

