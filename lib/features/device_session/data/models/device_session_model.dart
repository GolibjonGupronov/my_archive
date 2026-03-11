import 'package:my_archive/features/device_session/domain/entities/device_session_entity.dart';

class DeviceSessionModel extends DeviceSessionEntity {
  DeviceSessionModel({
    required super.deviceName,
    required super.operatingSystemType,
    required super.appVersion,
    required super.releaseVersion,
    required super.sdk,
    required super.address,
    required super.dateTime,
  });

  factory DeviceSessionModel.fromJson(Map<String, dynamic> json) => DeviceSessionModel(
        deviceName: json['device_name'],
        operatingSystemType: json['operating_system'],
        appVersion: json['app_version'],
        releaseVersion: json['release_version'],
        sdk: json['sdk'],
        address: json['address'],
        dateTime: json['date_time'],
      );

  Map<String, dynamic> toJson() => {
        'device_name': deviceName,
        'operating_system': operatingSystemType,
        'app_version': appVersion,
        'release_version': releaseVersion,
        'sdk': sdk,
        'address': address,
        'date_time': dateTime,
      };
}
