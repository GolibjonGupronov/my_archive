import 'package:dio/dio.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/auth/data/models/app_config_model.dart';
import 'package:my_archive/features/auth/data/models/user_info_model.dart';
import 'package:my_archive/features/auth/domain/use_cases/check_sms_use_case.dart';
import 'package:my_archive/features/auth/domain/use_cases/login_use_case.dart';
import 'package:my_archive/features/auth/domain/use_cases/registration_use_case.dart';

abstract class AuthDataSource {
  Future<bool> sendPhone(String phone);

  Future<String> sendLogin(LoginParams params);

  Future<bool> checkSms(CheckSmsParams params);

  Future<UserInfoModel> getUserInfo();

  Future<AppConfigModel> appConfig();

  Future<bool> registration(RegistrationParams params);
}

class AuthDataSourceImpl extends AuthDataSource {
  final Dio dio;

  AuthDataSourceImpl({required this.dio});

  @override
  Future<bool> sendPhone(String phone) async {
    final response = await dio.mock(data: true).post(ApiUrls.sendPhone, data: {"phone": phone});
    return response.data;
  }

  @override
  Future<bool> checkSms(CheckSmsParams params) async {
    final isCorrect = params.sms.contains('1111');

    final response = await dio
        .mock(data: true, statusCode: isCorrect ? 200 : 300, message: "SMS parol xato")
        .post(ApiUrls.checkSms, data: params.toMap);
    return response.data;
  }

  @override
  Future<UserInfoModel> getUserInfo() async {
    final data = UserInfoModel(
        firstName: "G'olibjon",
        secondName: "G'upronov",
        gender: Gender.male,
        birthday: "29.02.2000",
        phone: "+998999940941",
        image: "https://picsum.photos/400/200?3");
    final response = await dio.mock(data: data).get(ApiUrls.userInfo);
    return UserInfoModel.fromJson(response.data);
  }

  @override
  Future<AppConfigModel> appConfig() async {
    final data = AppConfigModel(
        iosMinimumBuildCode: 1, androidMinimumBuildCode: 1, googlePlayLink: "googlePlayLink", appStoreLink: "appStoreLink");
    final response = await dio.mock(data: data).get(ApiUrls.appConfig);
    return AppConfigModel.fromJson(response.data);
  }

  @override
  Future<bool> registration(RegistrationParams params) async {
    final isCorrect = params.smsCode.contains('1111');
    final response = await dio
        .mock(data: true, statusCode: isCorrect ? 200 : 300, message: "SMS parol xato")
        .post(ApiUrls.registration, data: params.toMap);
    return response.data;
  }

  @override
  Future<String> sendLogin(LoginParams params) async {
    final data = params.phone.contains("+998999940941") && params.password.contains("11111111");
    final response = await dio.mock(
        data: {"token": "TOKEN KELDI"},
        statusCode: data ? 200 : 300,
        message: "Login Parol Xato").post(ApiUrls.sendLogin, data: params.toMap);
    return response.data['token'];
  }
}
