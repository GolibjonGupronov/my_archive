import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/profile/domain/use_cases/edit_profile_use_case.dart';

abstract class ProfileRepository {
  Future<Either<Failure, String>> changeImage(String params);

  Future<Either<Failure, bool>> editProfile(EditProfileParams params);

  Future<Either<Failure, bool>> enableNotification(bool params);
}
