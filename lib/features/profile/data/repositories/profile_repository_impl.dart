import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/profile/data/data_sources/profile_data_source.dart';
import 'package:my_archive/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl with SafeCaller implements ProfileRepository {
  final ProfileDataSource profileDataSource;

  ProfileRepositoryImpl({required this.profileDataSource});

  @override
  Future<Either<Failure, String>> changeImage(String params) {
    return safeCall(() async => await profileDataSource.changeImage(params));
  }

  @override
  Future<Either<Failure, bool>> enableNotification(bool params) {
    return safeCall(() async => await profileDataSource.enableNotification(params));
  }
}
