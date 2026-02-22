import 'package:my_archive/core/api/error/failure.dart';
import 'package:my_archive/core/use_cases/usecase.dart';
import 'package:my_archive/core/utils/either.dart';
import 'package:my_archive/features/auth/domain/entities/send_phone_response_entity.dart';
import 'package:my_archive/features/auth/domain/repositories/auth_repository.dart';

class SendPhoneUseCase extends UseCase<SendPhoneResponseEntity, SendPhoneParams> {
  final AuthRepository repository;

  SendPhoneUseCase({required this.repository});

  @override
  Future<Either<Failure, SendPhoneResponseEntity>> call(SendPhoneParams params) async {
    return await repository.sendPhone(params);
  }
}

class SendPhoneParams {
  final String username;
  final String password;

  SendPhoneParams({required this.username,required this.password});

  Map<String, dynamic> get toMap => {
        'username': username,
        'password': password,
      };
}
