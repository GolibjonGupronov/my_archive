import 'package:my_archive/features/device_session/domain/entities/device_session_entity.dart';

class DeviceSessionModel extends DeviceSessionEntity {
  DeviceSessionModel({
    required super.deviceName,
    required super.operatingSystem,
    required super.appVersion,
    required super.releaseVersion,
    required super.sdk,
    required super.address,
    required super.dateTime,
  });

  factory DeviceSessionModel.fromJson(Map<String, dynamic> json) => DeviceSessionModel(
        deviceName: json['device_name'],
        operatingSystem: json['operating_system'],
        appVersion: json['app_version'],
        releaseVersion: json['release_version'],
        sdk: json['sdk'],
        address: json['address'],
        dateTime: json['date_time'],
      );

  Map<String, dynamic> toJson() => {
        'device_name': deviceName,
        'operating_system': operatingSystem,
        'app_version': appVersion,
        'release_version': releaseVersion,
        'sdk': sdk,
        'address': address,
        'date_time': dateTime,
      };
}
