import 'package:my_archive/core/api/error/failure.dart';
import 'package:my_archive/core/utils/either.dart';
import 'package:my_archive/features/auth/domain/entities/send_phone_response_entity.dart';
import 'package:my_archive/features/auth/domain/use_cases/send_phone_use_case.dart';

abstract class AuthRepository {
  Future<Either<Failure, SendPhoneResponseEntity>> sendPhone(SendPhoneParams params);
}