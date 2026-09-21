import 'package:my_archive/core/exports/data_exports.dart';
import 'package:my_archive/features/profile/data/data_sources/profile_data_source.dart';
import 'package:my_archive/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl with SafeCaller implements ProfileRepository {
  final ProfileDataSource profileDataSource;

  ProfileRepositoryImpl({required this.profileDataSource});

  @override
  Future<Either<Failure, String>> changeImage(String params) {
    return safeCall(() => profileDataSource.changeImage(params));
  }

  @override
  Future<Either<Failure, bool>> enableNotification(bool params) {
    return safeCall(() => profileDataSource.enableNotification(params));
  }
}
