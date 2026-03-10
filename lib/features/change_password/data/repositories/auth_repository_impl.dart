import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/auth/data/data_sources/auth_data_source.dart';
import 'package:my_archive/features/change_password/data/data_sources/change_password_data_source.dart';
import 'package:my_archive/features/change_password/domain/repositories/change_password_repository.dart';

class ChangePasswordRepositoryImpl with SafeCaller implements ChangePasswordRepository {
  final ChangePasswordDataSource changePasswordDataSource;
  final PrefManager prefManager;

  ChangePasswordRepositoryImpl({required this.changePasswordDataSource, required this.prefManager});

  @override
  Future<Either<Failure, bool>> oldPassword(String params) {
    return safeCall(() async => await changePasswordDataSource.oldPassword(params));
  }

  @override
  Future<Either<Failure, bool>> newPassword(String params) {
    return safeCall(() async => await changePasswordDataSource.newPassword(params));
  }
}
