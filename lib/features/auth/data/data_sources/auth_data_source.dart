import 'package:my_archive/core/exports/data_exports.dart';
import 'package:my_archive/features/auth/data/models/app_config_model.dart';
import 'package:my_archive/features/auth/data/models/user_info_model.dart';

abstract class AuthDataSource {
  Future<bool> sendPhone(String phone);

  Future<String> sendLogin(LoginParams params);

  Future<bool> checkSms(CheckSmsParams params);

  Future<UserInfoModel> getUserInfo();

  Future<AppConfigModel> appConfig();

  Future<bool> registration(RegistrationParams params);
}
