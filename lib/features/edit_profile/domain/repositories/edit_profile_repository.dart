import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/edit_profile/domain/use_cases/edit_profile_use_case.dart';

abstract class EditProfileRepository {
  Future<Either<Failure, bool>> editProfile(EditProfileParams params);
}
