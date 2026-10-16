import 'package:my_archive/core/exports/data_exports.dart';

abstract class EditProfileDataSource {
  Future<bool> editProfile(EditProfileParams params);
}
