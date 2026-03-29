import 'dart:convert';

import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/auth/data/models/user_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PrefManager {
  String get getToken;

  Future<void> setToken(String token);

  LangType get getLanguage;

  Future<void> setLanguage(LangType lang);

  UserInfoModel? get getUserInfo;

  Future<void> setUserInfo(UserInfoModel user);

  Future<void> remove(String key);

  bool get isFirstLaunch;

  Future<void> setNotFirstLaunch(bool value);

  String get getFCMToken;

  Future<void> setFCMToken(String value);

  bool? get isBiometric;

  Future<void> setBiometric(bool value);
}

class PrefManagerImpl implements PrefManager {
  final SharedPreferences prefs;

  PrefManagerImpl({required this.prefs});

  static const String _token = 'token';
  static const String _language = 'language';
  static const String _user = 'user';
  static const String _firstLaunch = 'first_launch';
  static const String _fcmToken = "fcm_token";
  static const String _biometric = "is_biometric";

  @override
  String get getToken => prefs.getString(_token) ?? "";

  @override
  Future<void> setToken(String token) async => await prefs.setString(_token, token);

  @override
  UserInfoModel? get getUserInfo {
    final data = prefs.getString(_user);
    return data == null ? null : UserInfoModel.fromJson(jsonDecode(data));
  }

  @override
  Future<void> setUserInfo(UserInfoModel user) async => await prefs.setString(_user, jsonEncode(user.toJson()));

  @override
  Future<void> remove(String key) async => await prefs.remove(key);

  @override
  LangType get getLanguage => LangType.getObj(prefs.getString(_language) ?? LangType.uz.key);

  @override
  Future<void> setLanguage(LangType lang) async => await prefs.setString(_language, lang.key);

  @override
  bool get isFirstLaunch => prefs.getBool(_firstLaunch) ?? true;

  @override
  Future<void> setNotFirstLaunch(bool value) async => await prefs.setBool(_firstLaunch, value);

  @override
  String get getFCMToken => prefs.getString(_fcmToken) ?? "";

  @override
  Future<void> setFCMToken(String value) async => await prefs.setString(_fcmToken, value);

  @override
  bool? get isBiometric => prefs.getBool(_biometric);

  @override
  Future<void> setBiometric(bool value) async => await prefs.setBool(_biometric, value);
}
