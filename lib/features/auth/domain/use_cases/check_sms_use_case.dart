import 'package:my_archive/core/exports/domain_exports.dart';
import 'package:my_archive/features/auth/domain/repositories/auth_repository.dart';

class CheckSmsUseCase extends UseCase<bool, CheckSmsParams> {
  final AuthRepository repository;

  CheckSmsUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> callUseCase(CheckSmsParams params) => repository.checkSms(params);
}

