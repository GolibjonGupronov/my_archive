import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/auth/data/data_sources/auth_data_source.dart';
import 'package:my_archive/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:my_archive/features/auth/domain/repositories/auth_repository.dart';
import 'package:my_archive/features/auth/domain/use_cases/app_config_use_case.dart';
import 'package:my_archive/features/auth/domain/use_cases/check_sms_use_case.dart';
import 'package:my_archive/features/auth/domain/use_cases/registration_use_case.dart';
import 'package:my_archive/features/auth/domain/use_cases/send_phone_use_case.dart';
import 'package:my_archive/features/auth/domain/use_cases/user_info_use_case.dart';

void initAuthInjection() {
  sl.registerSingleton<AuthDataSource>(AuthDataSourceImpl(dio: sl()));
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(authDataSource: sl(), prefManager: sl()));
  sl.registerSingleton<SendPhoneUseCase>(SendPhoneUseCase(repository: sl()));
  sl.registerSingleton<RegistrationUseCase>(RegistrationUseCase(repository: sl()));
  sl.registerSingleton<CheckSmsUseCase>(CheckSmsUseCase(repository: sl()));
  sl.registerSingleton<AppConfigUseCase>(AppConfigUseCase(repository: sl()));
  sl.registerSingleton<UserInfoUseCase>(UserInfoUseCase(repository: sl()));
  // sl.registerFactory(() => PhoneBloc(sendPhoneUseCase: sl()));
}
