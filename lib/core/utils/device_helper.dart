import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceHelper {
  static PackageInfo? _packageInfo;
  static IosDeviceInfo? _iosInfo;
  static AndroidDeviceInfo? _androidInfo;
  static late DeviceInfoPlugin _deviceInfo;

  static bool _initialized = false;

  static Future<void> init() async {
    _deviceInfo = DeviceInfoPlugin();
    _packageInfo = await PackageInfo.fromPlatform();

    if (Platform.isIOS) {
      _iosInfo = await _deviceInfo.iosInfo;
    } else if (Platform.isAndroid) {
      _androidInfo = await _deviceInfo.androidInfo;
    }

    _initialized = true;
  }

  static void _checkInit() {
    if (!_initialized) {
      throw Exception('DeviceHelper not initialized');
    }
  }

  static PackageInfo get packageInfo {
    _checkInit();
    return _packageInfo!;
  }

  static DeviceInfoPlugin get deviceInfo {
    _checkInit();
    return _deviceInfo;
  }

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
