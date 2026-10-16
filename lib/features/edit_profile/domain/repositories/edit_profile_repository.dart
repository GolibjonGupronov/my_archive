import 'package:my_archive/core/exports/domain_exports.dart';

abstract class EditProfileRepository {
  Future<Either<Failure, bool>> editProfile(EditProfileParams params);
}
