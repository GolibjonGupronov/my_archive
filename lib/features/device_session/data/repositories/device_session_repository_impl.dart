import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/device_session/data/data_sources/device_session_data_source.dart';
import 'package:my_archive/features/device_session/domain/entities/device_session_entity.dart';
import 'package:my_archive/features/device_session/domain/repositories/device_session_repository.dart';

class DeviceSessionRepositoryImpl with SafeCaller implements DeviceSessionRepository {
  final DeviceSessionDataSource deviceSessionDataSource;

  DeviceSessionRepositoryImpl({required this.deviceSessionDataSource});

  @override
  Future<Either<Failure, List<DeviceSessionEntity>>> getDeviceSessions() {
    return safeCall(() async => await deviceSessionDataSource.getDeviceSessions());
  }

  @override
  Future<Either<Failure, bool>> terminateDevice(int params) {
    return safeCall(() async => await deviceSessionDataSource.terminateDevice(params));
  }
}
