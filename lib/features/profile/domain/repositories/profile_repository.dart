import 'package:my_archive/core/core_exports.dart';

abstract class ProfileRepository {
  Future<Either<Failure, String>> changeImage(String params);
}