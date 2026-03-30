import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:local_auth/local_auth.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceHelper {
  static final LocalAuthentication _localAuthentication = LocalAuthentication();
  static PackageInfo? _packageInfo;
  static IosDeviceInfo? _iosInfo;
  static AndroidDeviceInfo? _androidInfo;
  static late DeviceInfoPlugin _deviceInfo;
  static bool _canUseBiometric = false;

  static Future<void> init() async {
    _deviceInfo = DeviceInfoPlugin();
    _packageInfo = await PackageInfo.fromPlatform();
    _canUseBiometric = (await _localAuthentication.canCheckBiometrics && await _localAuthentication.isDeviceSupported());

    if (Platform.isIOS) {
      _iosInfo = await _deviceInfo.iosInfo;
    } else if (Platform.isAndroid) {
      _androidInfo = await _deviceInfo.androidInfo;
    }
  }

  static PackageInfo get packageInfo => _packageInfo!;

  static DeviceInfoPlugin get deviceInfo => _deviceInfo;

  static bool get canUseBiometric => _canUseBiometric;

  static bool get isIpad {
    if (!Platform.isIOS || _iosInfo == null) return false;
    return _iosInfo!.model.toLowerCase().contains('ipad');
  }

  static AndroidDeviceInfo? get androidInfo {
    if (!Platform.isAndroid || _androidInfo == null) return null;
    return _androidInfo!;
  }

  static IosDeviceInfo? get iosInfo {
    if (!Platform.isIOS || _iosInfo == null) return null;
    return _iosInfo!;
  }
}
