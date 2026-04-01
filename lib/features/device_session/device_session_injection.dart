import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/device_session/data/data_sources/device_session_data_source.dart';
import 'package:my_archive/features/device_session/data/repositories/device_session_repository_impl.dart';
import 'package:my_archive/features/device_session/domain/repositories/device_session_repository.dart';
import 'package:my_archive/features/device_session/domain/use_cases/device_session_use_case.dart';
import 'package:my_archive/features/device_session/domain/use_cases/terminate_device_use_case.dart';

void initDeviceSessionInjection() {
  sl.registerSingleton<DeviceSessionDataSource>(DeviceSessionDataSourceImpl(dio: sl()));
  sl.registerSingleton<DeviceSessionRepository>(DeviceSessionRepositoryImpl(deviceSessionDataSource: sl()));
  sl.registerSingleton<DeviceSessionUseCase>(DeviceSessionUseCase(repository: sl()));
  sl.registerSingleton<TerminateDeviceUseCase>(TerminateDeviceUseCase(repository: sl()));
}
