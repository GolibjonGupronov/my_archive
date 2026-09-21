import 'package:my_archive/core/exports/data_exports.dart';
import 'package:my_archive/core/extensions/string.dart';
import 'package:my_archive/core/local_storage/pref_manager.dart';
import 'package:my_archive/core/local_storage/secure_storage.dart';
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
  final SecureStorage secureStorage;

  AuthRepositoryImpl({required this.authDataSource, required this.prefManager, required this.secureStorage});

  @override
  Future<Either<Failure, bool>> sendPhone(String phone) async {
    return safeCall<bool>(() => authDataSource.sendPhone(phone));
  }

  @override
  Future<Either<Failure, bool>> checkSms(CheckSmsParams params) {
    return safeCall(() => authDataSource.checkSms(params));
  }

  @override
  Future<Either<Failure, UserInfoEntity>> getUserInfo() {
    return safeCall2(
      () => authDataSource.getUserInfo(),
      onSuccess: prefManager.setUserInfo,
    );
  }

  @override
  Future<Either<Failure, AppConfigEntity>> appConfig() {
    return safeCall2(() => authDataSource.appConfig(), onSuccess: (data) async {
      await prefManager.setAppConfig(data);
      await prefManager.setServerDate(data.serverDate.formattedDate);
    });
  }

  @override
  Future<Either<Failure, bool>> registration(RegistrationParams params) {
    return safeCall(() => authDataSource.registration(params));
  }

  @override
  Future<Either<Failure, String>> sendLogin(LoginParams params) {
    return safeCall2(
      () => authDataSource.sendLogin(params),
      onSuccess: secureStorage.setToken,
    );
  }
}
