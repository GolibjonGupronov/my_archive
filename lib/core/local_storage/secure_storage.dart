import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorage {
  Future<bool> checkPin(String pin);

  Future<bool> hasPin();

  Future<void> savePin(String pin);

  Future<String> getPin();
}

class SecureStorageImpl extends SecureStorage {
  final FlutterSecureStorage storage;

  SecureStorageImpl({required this.storage});

  static const String _pinKey = 'user_pin';

  @override
  Future<bool> checkPin(String pin) async {
    final saved = await getPin();
    return saved == pin;
  }

  @override
  Future<void> savePin(String pin) async {
    await storage.write(key: _pinKey, value: pin);
  }

  @override
  Future<String> getPin() async {
    return await storage.read(key: _pinKey) ?? "";
  }

  @override
  Future<bool> hasPin() async {
    return (await getPin()).isNotEmpty;
  }
}
