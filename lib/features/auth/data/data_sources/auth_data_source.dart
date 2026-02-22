import 'package:dio/dio.dart';
import 'package:my_archive/core/api/api_urls/api_urls.dart';
import 'package:my_archive/core/api/error/base_response.dart';
import 'package:my_archive/features/auth/data/models/send_phone_response_model.dart';
import 'package:my_archive/features/auth/domain/use_cases/send_phone_use_case.dart';

abstract class AuthDataSource {
  // Future<BaseResponse> sendPhone(SendPhoneParams params);
  Future<SendPhoneResponseModel> sendPhone(SendPhoneParams params);
}

class AuthDataSourceImpl extends AuthDataSource {
  final Dio dio;

  AuthDataSourceImpl({required this.dio});

  // @override
  // Future<BaseResponse> sendPhone(SendPhoneParams params) async {
  //   final response = await dio.post(ApiUrls.sendPhone, data: params.toMap);
  //   return BaseResponse.fromJson(response.data);
  // }
  @override
  Future<SendPhoneResponseModel> sendPhone(SendPhoneParams params) async {
    final response = await dio.post(ApiUrls.sendPhone, data: params.toMap);
    return SendPhoneResponseModel.fromJson(response.data);
  }
}
