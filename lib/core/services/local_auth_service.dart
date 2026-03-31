import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';
import 'package:my_archive/core/core_exports.dart';

class LocalAuthService {
  static final LocalAuthentication _localAuthentication = LocalAuthentication();
  static final PrefManager _prefManager = sl.get<PrefManager>();

  static Future<void> tryBiometric() async {
    if (canUseBiometric) {
      bool ok = await authenticate();
      debugPrint("GGQ => biometric auth result: $ok");
      _prefManager.setBiometric(ok);
    }
  }

  static bool get canUseBiometric => DeviceHelper.canUseBiometric;

  static Future<bool> authenticate() async {
    try {
      debugPrint("GGQ => authenticate");
      return await _localAuthentication.authenticate(
        localizedReason: 'Qulfni ochish uchun tasdiqlang',
        authMessages: <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: 'Qulfni ochish',
            signInHint: 'Tasdiqlash',
            cancelButton: 'Bekor qilish',
          ),
          const IOSAuthMessages(
            cancelButton: 'Bekor qilish',
          ),
        ],
        biometricOnly: true,
        // persistAcrossBackgrounding: true,
      );
    } catch (e) {
      debugPrint("GGQ => error $e");
      return false;
    }
  }
}
