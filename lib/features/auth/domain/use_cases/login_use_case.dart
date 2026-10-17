import 'package:my_archive/core/exports/domain_exports.dart';
import 'package:my_archive/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase extends UseCase<String, LoginParams> {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> callUseCase(LoginParams params) => repository.sendLogin(params);
}
