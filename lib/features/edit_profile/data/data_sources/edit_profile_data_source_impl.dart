import 'package:dio/dio.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/edit_profile/data/data_sources/edit_profile_data_source.dart';
import 'package:my_archive/features/edit_profile/domain/use_cases/edit_profile_use_case.dart';

class EditProfileDataSourceImpl extends EditProfileDataSource {
  final Dio dio;

  EditProfileDataSourceImpl({required this.dio});

  @override
  Future<bool> editProfile(EditProfileParams params) async {
    final response = await dio.mock(data: true).post(ApiUrls.editProfile, data: params.toMap);
    return response.data;
  }
}
