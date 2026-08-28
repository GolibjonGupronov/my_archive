import 'package:my_archive/core/exports/core_exports.dart';

abstract class ProfileRepository {
  Future<Either<Failure, String>> changeImage(String params);

  Future<Either<Failure, bool>> enableNotification(bool params);
}
