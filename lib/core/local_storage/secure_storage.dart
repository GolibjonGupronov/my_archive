import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_archive/core/constants/keys.dart';

abstract class SecureStorage {
  Future<String> get getToken;

  Future<void> setToken(String token);

  Future<bool> checkPin(String pin);

  Future<bool> get hasPin;

  Future<void> savePin(String pin);

  Future<String> get getPin;

  Future<void> delete(String key);
}

class SecureStorageImpl extends SecureStorage {
  final FlutterSecureStorage storage;

  SecureStorageImpl({required this.storage});

  @override
  Future<String> get getToken async => await storage.read(key: Keys.token) ?? "";

  @override
  Future<void> setToken(String token) async => await storage.write(key: Keys.token, value: token);

  @override
  Future<bool> checkPin(String pin) async => (await getPin) == pin;

  @override
  Future<void> savePin(String pin) async => await storage.write(key: Keys.pinKey, value: pin);

  @override
  Future<String> get getPin async => await storage.read(key: Keys.pinKey) ?? "";

  @override
  Future<bool> get hasPin async => (await getPin).isNotEmpty;

  @override
  Future<void> delete(String key) async => await storage.delete(key: key);
}
