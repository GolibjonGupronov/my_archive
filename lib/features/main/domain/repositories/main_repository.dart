import 'package:my_archive/core/core_exports.dart';

abstract class MainRepository {
  Future<Either<Failure, bool>> checkSession();

  Future<Either<Failure, Stream<bool>>> watchSession();
}