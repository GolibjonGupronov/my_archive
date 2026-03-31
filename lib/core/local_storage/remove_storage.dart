import 'package:my_archive/core/constants/keys.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/core/local_storage/secure_storage.dart';

class RemoveStorage {
  static final _prefManager = sl.get<PrefManager>();
  static final _secureStorage = sl.get<SecureStorage>();

  static Future<void> clearToken() async {
    await _prefManager.remove(Keys.token);
  }

  static Future<void> logoutApp() async {
    await clearToken();
    await _prefManager.remove(Keys.biometric);
    await _prefManager.remove(Keys.autoLockTime);
    await _secureStorage.delete(Keys.pinKey);
  }

  static Future<void> removePin() async {
    await _prefManager.remove(Keys.biometric);
    await _prefManager.remove(Keys.autoLockTime);
    await _secureStorage.delete(Keys.pinKey);
  }
}
