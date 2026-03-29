import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/auth/data/data_sources/auth_data_source.dart';
import 'package:my_archive/features/auth/domain/entities/app_config_entity.dart';
import 'package:my_archive/features/auth/domain/entities/user_info_entity.dart';
import 'package:my_archive/features/auth/domain/repositories/auth_repository.dart';
import 'package:my_archive/features/auth/domain/use_cases/check_sms_use_case.dart';
import 'package:my_archive/features/auth/domain/use_cases/login_use_case.dart';
import 'package:my_archive/features/auth/domain/use_cases/registration_use_case.dart';

class AuthRepositoryImpl with SafeCaller implements AuthRepository {
  final AuthDataSource authDataSource;
  final PrefManager prefManager;

  AuthRepositoryImpl({required this.authDataSource, required this.prefManager});

  @override
  Future<Either<Failure, bool>> sendPhone(String phone) async {
    return safeCall<bool>(() async => await authDataSource.sendPhone(phone));
  }

  @override
  Future<Either<Failure, bool>> checkSms(CheckSmsParams params) {
    return safeCall(() async => await authDataSource.checkSms(params));
  }

  @override
  Future<Either<Failure, UserInfoEntity>> getUserInfo({required bool isNotificationEnabled}) {
    return safeCall2(
      () async => await authDataSource.getUserInfo(isNotificationEnabled: isNotificationEnabled),
      onSuccess: (data) async => await prefManager.setUserInfo(data),
    );
  }

  @override
  Future<Either<Failure, AppConfigEntity>> appConfig() {
    return safeCall(() async => await authDataSource.appConfig());
  }

  @override
  Future<Either<Failure, bool>> registration(RegistrationParams params) {
    return safeCall(() async => await authDataSource.registration(params));
  }

  @override
  Future<Either<Failure, String>> sendLogin(LoginParams params) {
    return safeCall2(() async => await authDataSource.sendLogin(params),
        onSuccess: (data) async => await prefManager.setToken(data));
  }
}
