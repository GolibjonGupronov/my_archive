import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/main/data/data_sources/main_data_source.dart';
import 'package:my_archive/features/main/domain/repositories/main_repository.dart';

class MainRepositoryImpl with SafeCaller implements MainRepository {
  final MainDataSource mainDataSource;

  MainRepositoryImpl({required this.mainDataSource});

  @override
  Future<Either<Failure, bool>> checkSession() {
    return safeCall(() async => await mainDataSource.checkSession());
  }

  @override
  Future<Either<Failure, Stream<bool>>> watchSession() {
    return safeCall(() async => await mainDataSource.watchSession());
  }
}
