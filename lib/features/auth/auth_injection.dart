import 'package:my_archive/core/services/service_locator/service_locator.dart';
import 'package:my_archive/features/auth/data/data_sources/auth_data_source.dart';
import 'package:my_archive/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:my_archive/features/auth/domain/repositories/auth_repository.dart';
import 'package:my_archive/features/auth/domain/use_cases/send_phone_use_case.dart';

void initAuthInjection() {
  sl.registerSingleton<AuthDataSource>(AuthDataSourceImpl(dio: sl()));
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(authDataSource: sl()));
  sl.registerSingleton<SendPhoneUseCase>(SendPhoneUseCase(repository: sl()));
  // sl.registerFactory(() => PhoneBloc(sendPhoneUseCase: sl()));
}
