import 'package:my_archive/core/exports/domain_exports.dart';

abstract class MainRepository {
  Future<Either<Failure, bool>> checkSession();

  Future<Either<Failure, Stream<bool>>> watchSession();
}
