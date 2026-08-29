import 'package:my_archive/core/exports/core_exports.dart';
import 'package:my_archive/features/device_session/domain/entities/device_session_entity.dart';

abstract class DeviceSessionRepository {
  Future<Either<Failure, List<DeviceSessionEntity>>> getDeviceSessions();

  Future<Either<Failure, bool>> terminateDevice(String params);
}
