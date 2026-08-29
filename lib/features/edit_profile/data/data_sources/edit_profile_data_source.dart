import 'package:my_archive/features/edit_profile/domain/use_cases/edit_profile_use_case.dart';

abstract class EditProfileDataSource {
  Future<bool> editProfile(EditProfileParams params);
}
