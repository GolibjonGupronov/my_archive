import 'package:dio/dio.dart';
import 'package:my_archive/core/core_exports.dart';

abstract class ChangePasswordDataSource {
  Future<bool> oldPassword(String params);

  Future<bool> newPassword(String params);
}

class ChangePasswordDataSourceImpl extends ChangePasswordDataSource {
  final Dio dio;

  ChangePasswordDataSourceImpl({required this.dio});

  @override
  Future<bool> oldPassword(String params) async {
    final data = params.contains("11111111");
    final response = await dio
        .mock(data: true, statusCode: data ? 200 : 300, message: "Parol Xato")
        .post(ApiUrls.oldPassword, data: {"old_password": params});
    return response.data;
  }

  @override
  Future<bool> newPassword(String params) async {
    final response = await dio.mock(data: true).post(ApiUrls.newPassword, data: {"new_password": params});
    return response.data;
  }
}
