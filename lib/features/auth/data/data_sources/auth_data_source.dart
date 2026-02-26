import 'package:dio/dio.dart';
import 'package:my_archive/core/api/api_urls/api_urls.dart';
import 'package:my_archive/core/api/dio/dio_mock.dart';
import 'package:my_archive/core/enums/gender.dart';
import 'package:my_archive/features/auth/data/models/app_config_model.dart';
import 'package:my_archive/features/auth/data/models/send_phone_response_model.dart';
import 'package:my_archive/features/auth/data/models/user_info_model.dart';
import 'package:my_archive/features/auth/domain/use_cases/check_sms_use_case.dart';

abstract class AuthDataSource {
  Future<SendPhoneResponseModel> sendPhone(String phone);

  Future<bool> checkSms(CheckSmsParams params);

  Future<UserInfoModel> getUserInfo();

  Future<AppConfigModel> appConfig();
}

class AuthDataSourceImpl extends AuthDataSource {
  final Dio dio;

  AuthDataSourceImpl({required this.dio});

  @override
  Future<SendPhoneResponseModel> sendPhone(String phone) async {
    final data = SendPhoneResponseModel(phone: phone, isRegistered: phone.contains("+998999940941"));
    final response = await dio.mock(data: data).post(ApiUrls.sendPhone, data: {"phone": phone});
    return SendPhoneResponseModel.fromJson(response.data);
  }

  @override
  Future<bool> checkSms(CheckSmsParams params) async {
    final response = await dio.post(ApiUrls.checkSms, data: params.toMap);
    return response.data;
  }

  @override
  Future<UserInfoModel> getUserInfo() async {
    final data = UserInfoModel(firstName: "G'olibjon", secondName: "G'upronov", gender: Gender.male, birthday: "29.02.2000");
    final response = await dio.mock(data: data).post(ApiUrls.userInfo);
    return UserInfoModel.fromJson(response.data);
  }

  @override
  Future<AppConfigModel> appConfig() async {
    final data = AppConfigModel(
        iosMinimumBuildCode: 1, androidMinimumBuildCode: 1, googlePlayLink: "googlePlayLink", appStoreLink: "appStoreLink");
    final response = await dio.mock(data: data).post(ApiUrls.appConfig);
    return AppConfigModel.fromJson(response.data);
  }
}
