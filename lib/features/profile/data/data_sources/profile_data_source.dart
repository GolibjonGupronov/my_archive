import 'package:dio/dio.dart';
import 'package:my_archive/core/core_exports.dart';

abstract class ProfileDataSource {
  Future<String> changeImage(String params);
}

class ProfileDataSourceImpl extends ProfileDataSource {
  final Dio dio;

  ProfileDataSourceImpl({required this.dio});

  @override
  Future<String> changeImage(String params) async {
    final data = {"image": params};

    final formData = FormData.fromMap({'image': await MultipartFile.fromFile(params, filename: params)});

    final response = await dio.mock(data: data).post(ApiUrls.changeImage, data: formData);
    return response.data['image'];
  }
}
