import 'package:flutter/material.dart';

enum OperatingSystemType {
  android,
  ios;

  static OperatingSystemType getObj(String key) => switch (key) {
        'android' => OperatingSystemType.android,
        'ios' => OperatingSystemType.ios,
        _ => OperatingSystemType.android,
      };

  String get key => switch (this) {
        OperatingSystemType.android => 'android',
        OperatingSystemType.ios => 'ios',
      };

  String get title => switch (this) {
        OperatingSystemType.android => 'Android',
        OperatingSystemType.ios => 'Iphone',
      };

  IconData get icon => switch (this) {
        OperatingSystemType.android => Icons.android,
        OperatingSystemType.ios => Icons.apple,
      };
}

class DeviceSessionEntity {
  final int id;
  final String deviceName;
  final OperatingSystemType operatingSystemType;
  final String appVersion;
  final String releaseVersion;
  final String sdk;
  final String address;
  final String dateTime;
  final bool isCurrent;

  DeviceSessionEntity({
    required this.id,
    required this.deviceName,
    required this.operatingSystemType,
    required this.appVersion,
    required this.releaseVersion,
    required this.sdk,
    required this.address,
    required this.dateTime,
    required this.isCurrent,
  });
}
