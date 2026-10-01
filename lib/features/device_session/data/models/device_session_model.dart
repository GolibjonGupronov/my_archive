import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_archive/core/enums/common.dart';
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
      deviceId: json['device_id'] as String,
      deviceName: json['device_name'] as String,
      operatingSystemType: OperatingSystemType.getObj(json['operating_system'] as String),
      appVersion: json['app_version'] as String,
      releaseVersion: json['release_version'] as String,
      address: json['address'] == null ? null : LocationModel.fromJson(json['address'] as Map<String, dynamic>),
      dateTime: dateTime,
      isCurrent: json['is_current'] as bool,
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
