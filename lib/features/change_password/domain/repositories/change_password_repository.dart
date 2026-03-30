import 'package:my_archive/core/core_exports.dart';

abstract class ChangePasswordRepository {
  Future<Either<Failure, bool>> oldPassword(String params);

  Future<Either<Failure, bool>> newPassword(String params);
}
