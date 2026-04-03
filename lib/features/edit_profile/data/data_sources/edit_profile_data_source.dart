import 'package:dio/dio.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/edit_profile/domain/use_cases/edit_profile_use_case.dart';
import 'package:my_archive/features/faq/data/models/faq_model.dart';

abstract class EditProfileDataSource {
  Future<bool> editProfile(EditProfileParams params);

}

class EditProfileDataSourceImpl extends EditProfileDataSource {
  final Dio dio;

  EditProfileDataSourceImpl({required this.dio});

  @override
  Future<bool> editProfile(EditProfileParams params) async {
    final response = await dio.mock(data: true).post(ApiUrls.editProfile, data: params.toMap);
    return response.data;
  }
}
