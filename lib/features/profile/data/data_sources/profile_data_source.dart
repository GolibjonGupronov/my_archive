import 'package:dio/dio.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/profile/domain/use_cases/edit_profile_use_case.dart';

abstract class ProfileDataSource {
  Future<String> changeImage(String params);

  Future<bool> editProfile(EditProfileParams params);

  Future<bool> enableNotification(bool params);
}

class ProfileDataSourceImpl extends ProfileDataSource {
  final Dio dio;

  ProfileDataSourceImpl({required this.dio});

  @override
  Future<String> changeImage(String params) async {
    final data = {"image": params};

    final formData = FormData.fromMap({if (params.isNotEmpty) 'image': await MultipartFile.fromFile(params, filename: params)});

    final response = await dio.mock(data: data).post(ApiUrls.changeImage, data: formData);
    return response.data['image'];
  }

  @override
  Future<bool> editProfile(EditProfileParams params) async {
    final response = await dio.mock(data: true).post(ApiUrls.editProfile, data: params.toMap);
    return response.data;
  }

  @override
  Future<bool> enableNotification(bool params) async {
    final response = await dio.mock(data: true).post(ApiUrls.enableNotification, data: {"enable": params});
    return response.data;
  }
}
