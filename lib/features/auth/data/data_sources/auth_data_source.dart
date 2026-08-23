import 'package:my_archive/features/auth/data/models/app_config_model.dart';
import 'package:my_archive/features/auth/data/models/user_info_model.dart';
import 'package:my_archive/features/auth/domain/use_cases/check_sms_use_case.dart';
import 'package:my_archive/features/auth/domain/use_cases/login_use_case.dart';
import 'package:my_archive/features/auth/domain/use_cases/registration_use_case.dart';

abstract class AuthDataSource {
  Future<bool> sendPhone(String phone);

  Future<String> sendLogin(LoginParams params);

  Future<bool> checkSms(CheckSmsParams params);

  Future<UserInfoModel> getUserInfo({required bool isNotificationEnabled});

  Future<AppConfigModel> appConfig();

  Future<bool> registration(RegistrationParams params);
}
