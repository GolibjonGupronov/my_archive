import 'package:dio/dio.dart';
import 'package:my_archive/core/exports/core_exports.dart';
import 'package:my_archive/features/auth/data/data_sources/auth_data_source.dart';
import 'package:my_archive/features/auth/data/models/app_config_model.dart';
import 'package:my_archive/features/auth/data/models/user_info_model.dart';
import 'package:my_archive/features/auth/domain/use_cases/check_sms_use_case.dart';
import 'package:my_archive/features/auth/domain/use_cases/login_use_case.dart';
import 'package:my_archive/features/auth/domain/use_cases/registration_use_case.dart';

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
      image: "https://picsum.photos/400/200?3",
      isNotificationEnabled: false,
    );
    final response = await dio.mock(data: data).get(ApiUrls.userInfo);
    return UserInfoModel.fromJson(response.data);
  }

  @override
  Future<AppConfigModel> appConfig() async {
    final data = AppConfigModel(
      iosMinimumBuildCode: 1,
      androidMinimumBuildCode: 1,
      googlePlayLink: "https://play.google.com/store/apps/details?id=uz.evo_med_group.evo_med",
      appStoreLink: "https://apps.apple.com/us/app/evomed/id6758425374",
      callCenter: "0941",
      telegramBot: "https://t.me/m0b1leDevel0per",
      telegram: "https://t.me/m0b1leDevel0per",
      instagram: "https://www.instagram.com/golibjongupronov",
      facebook: "https://www.facebook.com/g.olibjon.g.upronov",
    );
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
