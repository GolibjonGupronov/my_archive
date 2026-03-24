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
}

class PrefManagerImpl implements PrefManager {
  final SharedPreferences prefs;

  PrefManagerImpl({required this.prefs});

  @override
  String get getToken => prefs.getString(Keys.token) ?? "";

  @override
  Future<void> setToken(String token) async => await prefs.setString(Keys.token, token);

  @override
  UserInfoModel? get getUserInfo {
    final data = prefs.getString(Keys.user);
    return data == null ? null : UserInfoModel.fromJson(jsonDecode(data));
  }

  @override
  Future<void> setUserInfo(UserInfoModel user) async => await prefs.setString(Keys.user, jsonEncode(user.toJson()));

  @override
  Future<void> remove(String key) async => await prefs.remove(key);

  @override
  LangType get getLanguage => LangType.getObj(prefs.getString(Keys.language) ?? LangType.uz.key);

  @override
  Future<void> setLanguage(LangType lang) async => await prefs.setString(Keys.language, lang.key);

  @override
  bool get isFirstLaunch => prefs.getBool(Keys.firstLaunch) ?? true;

  @override
  Future<void> setNotFirstLaunch(bool value) async => await prefs.setBool(Keys.firstLaunch, value);

  @override
  String get getFCMToken => prefs.getString(Keys.fcmToken) ?? "";

  @override
  Future<void> setFCMToken(String value) async => await prefs.setString(Keys.fcmToken, value);
}
