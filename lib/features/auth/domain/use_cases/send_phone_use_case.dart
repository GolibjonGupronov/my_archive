import 'package:my_archive/core/api/error/failure.dart';
import 'package:my_archive/core/use_cases/usecase.dart';
import 'package:my_archive/core/utils/either.dart';
import 'package:my_archive/features/auth/domain/entities/send_phone_response_entity.dart';
import 'package:my_archive/features/auth/domain/repositories/auth_repository.dart';

class SendPhoneUseCase extends UseCase<SendPhoneResponseEntity, String> {
  final AuthRepository repository;

  SendPhoneUseCase({required this.repository});

  @override
  Future<Either<Failure, SendPhoneResponseEntity>> call(String phone) async => await repository.sendPhone(phone);
}
