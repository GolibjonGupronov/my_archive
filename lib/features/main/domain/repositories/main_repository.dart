import 'package:my_archive/core/exports/core_exports.dart';

abstract class MainRepository {
  Future<Either<Failure, bool>> checkSession();

  Future<Either<Failure, Stream<bool>>> watchSession();
}