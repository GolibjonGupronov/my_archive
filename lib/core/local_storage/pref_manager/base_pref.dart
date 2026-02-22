import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class BasePrefs {
  final SharedPreferences prefs;

  BasePrefs(this.prefs);

  Future<void> remove(String key) async {
    await prefs.remove(key);
  }

  String getString(String key, {String defaultValue = ""}) => prefs.getString(key) ?? defaultValue;
  Future<bool> setString(String key, String value) async => await prefs.setString(key, value);

  int getInt(String key, {int defaultValue = 0}) => prefs.getInt(key) ?? defaultValue;
  Future<bool> setInt(String key, int value) async => await prefs.setInt(key, value);

  bool getBool(String key, {bool defaultValue = false}) => prefs.getBool(key) ?? defaultValue;
  Future<bool> setBool(String key, bool value) async => await prefs.setBool(key, value);

  double getDouble(String key, {double defaultValue = 0.0}) => prefs.getDouble(key) ?? defaultValue;
  Future<bool> setDouble(String key, double value) async => await prefs.setDouble(key, value);

  T getObject<T>(String key, T Function(Map<String, dynamic>) fromJson) {
    final data = prefs.getString(key);
    return fromJson(data != null ? jsonDecode(data) : {});
  }

  Future<bool> setObject<T>(String key, T object, Map<String, dynamic> Function(T) toJson) async {
    return await prefs.setString(key, jsonEncode(toJson(object)));
  }
}