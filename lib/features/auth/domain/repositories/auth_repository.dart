import 'package:my_archive/core/api/error/failure.dart';
import 'package:my_archive/core/utils/either.dart';
import 'package:my_archive/features/auth/domain/entities/app_config_entity.dart';
import 'package:my_archive/features/auth/domain/entities/user_info_entity.dart';
import 'package:my_archive/features/auth/domain/use_cases/check_sms_use_case.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> sendPhone(String phone);

  Future<Either<Failure, bool>> checkSms(CheckSmsParams params);

  Future<Either<Failure, UserInfoEntity>> getUserInfo();

  Future<Either<Failure, AppConfigEntity>> appConfig();
}
