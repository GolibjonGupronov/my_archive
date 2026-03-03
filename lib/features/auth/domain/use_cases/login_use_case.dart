import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase extends UseCase<String, LoginParams> {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> callUseCase(LoginParams params) async => await repository.sendLogin(params);
}

class LoginParams {
  final String phone;
  final String password;

  LoginParams({required this.phone, required this.password});

  Map<String, dynamic> get toMap => {
        'phone': phone,
        'password': password,
      };
}
