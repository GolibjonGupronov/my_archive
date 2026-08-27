import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/device_session/data/models/location_model.dart';
import 'package:my_archive/features/device_session/domain/entities/device_session_entity.dart';

class DeviceSessionModel extends DeviceSessionEntity {
  DeviceSessionModel({
    required super.deviceId,
    required super.deviceName,
    required super.operatingSystemType,
    required super.appVersion,
    required super.releaseVersion,
    required super.address,
    required super.dateTime,
    required super.isCurrent,
  });

  factory DeviceSessionModel.fromJson(Map<String, dynamic> json) {
    String dateTime = "";
    final date = json['date_time'];
    if (date is Timestamp) {
      dateTime = date.toDate().toIso8601String();
    } else if (date is String) {
      dateTime = date;
    }
    return DeviceSessionModel(
      deviceId: json['device_id'] ?? "",
      deviceName: json['device_name'] ?? "",
      operatingSystemType: OperatingSystemType.getObj(json['operating_system'] ?? ""),
      appVersion: json['app_version'] ?? "",
      releaseVersion: json['release_version'] ?? "",
      address: json['address'] == null ? null : LocationModel.fromJson(json['address']),
      dateTime: dateTime,
      isCurrent: json['is_current'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'device_id': deviceId,
        'device_name': deviceName,
        'operating_system': operatingSystemType.key,
        'app_version': appVersion,
        'release_version': releaseVersion,
        'address': (address as LocationModel?)?.toJson(),
        'date_time': dateTime,
        'is_current': isCurrent,
      };

  DeviceSessionModel copyWith({
    bool? isCurrent,
  }) {
    return DeviceSessionModel(
      deviceId: deviceId,
      deviceName: deviceName,
      operatingSystemType: operatingSystemType,
      appVersion: appVersion,
      releaseVersion: releaseVersion,
      address: address,
      dateTime: dateTime,
      isCurrent: isCurrent ?? this.isCurrent,
    );
  }
}
