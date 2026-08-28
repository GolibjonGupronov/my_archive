import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';
import 'package:my_archive/core/exports/core_exports.dart';

class LocalAuthService {
  static final LocalAuthentication _localAuthentication = LocalAuthentication();

  static Future<bool> tryBiometric() async {
    if (canUseBiometric) {
      bool auth = await authenticate();
      logger("GGQ => biometric auth result: $auth");
      return auth;
    }
    return false;
  }

  static bool get canUseBiometric => DeviceService.canUseBiometric;

  static Future<bool> authenticate() async {
    try {
      logger("GGQ => authenticate");
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
      logger("GGQ => error $e");
      return false;
    }
  }
}
