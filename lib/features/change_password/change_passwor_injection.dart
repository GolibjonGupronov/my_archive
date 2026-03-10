import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/change_password/data/data_sources/change_password_data_source.dart';
import 'package:my_archive/features/change_password/data/repositories/auth_repository_impl.dart';
import 'package:my_archive/features/change_password/domain/repositories/change_password_repository.dart';
import 'package:my_archive/features/change_password/domain/use_cases/new_password_use_case.dart';
import 'package:my_archive/features/change_password/domain/use_cases/old_password_use_case.dart';

void initChangePasswordInjection() {
  sl.registerSingleton<ChangePasswordDataSource>(ChangePasswordDataSourceImpl(dio: sl()));
  sl.registerSingleton<ChangePasswordRepository>(ChangePasswordRepositoryImpl(changePasswordDataSource: sl(), prefManager: sl()));
  sl.registerSingleton<NewPasswordUseCase>(NewPasswordUseCase(repository: sl()));
  sl.registerSingleton<OldPasswordUseCase>(OldPasswordUseCase(repository: sl()));
}
