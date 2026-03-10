class DeviceSessionEntity {
  final String deviceName;
  final String operatingSystem;
  final String appVersion;
  final String releaseVersion;
  final String sdk;
  final String address;
  final String dateTime;

  DeviceSessionEntity({
    required this.deviceName,
    required this.operatingSystem,
    required this.appVersion,
    required this.releaseVersion,
    required this.sdk,
    required this.address,
    required this.dateTime,
  });
}
