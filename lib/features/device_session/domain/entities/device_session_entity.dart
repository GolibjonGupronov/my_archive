import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/device_session/domain/entities/location_entity.dart';

class DeviceSessionEntity {
  final String deviceId;
  final String deviceName;
  final OperatingSystemType operatingSystemType;
  final String appVersion;
  final String releaseVersion;
  final LocationEntity? address;
  final String dateTime;
  final bool isCurrent;

  DeviceSessionEntity({
    required this.deviceId,
    required this.deviceName,
    required this.operatingSystemType,
    required this.appVersion,
    required this.releaseVersion,
    required this.address,
    required this.dateTime,
    required this.isCurrent,
  });
}
