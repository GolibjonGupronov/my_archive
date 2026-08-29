import 'package:dio/dio.dart';
import 'package:my_archive/core/exports/core_exports.dart';
import 'package:my_archive/features/profile/data/data_sources/profile_data_source.dart';

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
  Future<bool> enableNotification(bool params) async {
    final response = await dio.mock(data: true).post(ApiUrls.enableNotification, data: {"enable": params});
    return response.data;
  }
}
