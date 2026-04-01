import 'package:my_archive/features/device_session/domain/entities/device_session_entity.dart';

class DeviceSessionModel extends DeviceSessionEntity {
  DeviceSessionModel({
    required super.id,
    required super.deviceName,
    required super.operatingSystemType,
    required super.appVersion,
    required super.releaseVersion,
    required super.sdk,
    required super.address,
    required super.dateTime,
    required super.isCurrent,
  });

  factory DeviceSessionModel.fromJson(Map<String, dynamic> json) => DeviceSessionModel(
        id: json['id'],
        deviceName: json['device_name'],
        operatingSystemType: json['operating_system'],
        appVersion: json['app_version'],
        releaseVersion: json['release_version'],
        sdk: json['sdk'],
        address: json['address'],
        dateTime: json['date_time'],
        isCurrent: json['is_current'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'device_name': deviceName,
        'operating_system': operatingSystemType,
        'app_version': appVersion,
        'release_version': releaseVersion,
        'sdk': sdk,
        'address': address,
        'date_time': dateTime,
        'is_current': isCurrent,
      };
}
