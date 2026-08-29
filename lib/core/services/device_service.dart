import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:local_auth/local_auth.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceService {
  DeviceService._();

  static final LocalAuthentication _localAuthentication = LocalAuthentication();
  static bool _canUseBiometric = false;

  static const _androidIdPlugin = AndroidId();
  static late PackageInfo _packageInfo;
  static late String _deviceId;
  static late String _deviceModel;
  static late String _osVersion;
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  static Future<void> init() async {
    _packageInfo = await PackageInfo.fromPlatform();
    _canUseBiometric = (await _localAuthentication.canCheckBiometrics && await _localAuthentication.isDeviceSupported());

    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfoPlugin.androidInfo;
      _deviceId = await _androidIdPlugin.getId() ?? '';
      _deviceModel = "${androidInfo.brand} ${androidInfo.model}";
      _osVersion = androidInfo.version.release;
    } else if (Platform.isIOS) {
      final iosInfo = await _deviceInfoPlugin.iosInfo;
      _deviceId = iosInfo.identifierForVendor ?? "";
      _deviceModel = iosInfo.model;
      _osVersion = iosInfo.systemVersion;
    } else {
      _deviceId = "";
      _deviceModel = "";
      _osVersion = "";
    }
  }

  static bool get canUseBiometric => _canUseBiometric;

  // Ilova versiyasi (masalan: 1.0.0)
  static String get version => _packageInfo.version;

  // Build raqami (masalan: 1)
  static String get buildNumber => _packageInfo.buildNumber;

  // Qurilma ID si (Unique ID)
  static String get deviceId => _deviceId;

  // Qurilma modeli (masalan: Samsung S21)
  static String get deviceModel => _deviceModel;

  // Operatsion tizim versiyasi
  static String get osVersion => _osVersion;

  static PackageInfo get packageInfo => _packageInfo;

  static DeviceInfoPlugin get deviceInfo => _deviceInfoPlugin;
}
