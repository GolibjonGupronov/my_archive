import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_archive/core/constants/keys.dart';

abstract class SecureStorage {
  Future<bool> checkPin(String pin);

  Future<bool> hasPin();

  Future<void> savePin(String pin);

  Future<String> getPin();

  Future<void> delete(String key);
}

class SecureStorageImpl extends SecureStorage {
  final FlutterSecureStorage storage;

  SecureStorageImpl({required this.storage});

  @override
  Future<bool> checkPin(String pin) async => (await getPin()) == pin;

  @override
  Future<void> savePin(String pin) async => await storage.write(key: Keys.pinKey, value: pin);

  @override
  Future<String> getPin() async => await storage.read(key: Keys.pinKey) ?? "";

  @override
  Future<bool> hasPin() async => (await getPin()).isNotEmpty;

  @override
  Future<void> delete(String key) async => await storage.delete(key: key);
}
