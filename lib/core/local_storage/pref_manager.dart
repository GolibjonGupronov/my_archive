import 'dart:convert';

import 'package:my_archive/core/constants/keys.dart';
import 'package:my_archive/core/exports/core_exports.dart';
import 'package:my_archive/features/auth/data/models/app_config_model.dart';
import 'package:my_archive/features/auth/data/models/user_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PrefManager {
  LangType get getLanguage;

  Future<void> setLanguage(LangType lang);

  UserInfoModel? get getUserInfo;

  Future<void> setUserInfo(UserInfoModel user);

  bool get isFirstLaunch;

  Future<void> setNotFirstLaunch(bool value);

  String get getFCMToken;

  Future<void> setFCMToken(String value);

  bool get isBiometric;

  Future<void> setBiometric(bool value);

  Future<void> remove(String key);

  AutoLockTimeType get getAutoLockTime;

  Future<void> setAutoLockTime(AutoLockTimeType value);

  AppConfigModel? get getAppConfig;

  Future<void> setAppConfig(AppConfigModel value);
}

class PrefManagerImpl implements PrefManager {
  final SharedPreferences prefs;

  PrefManagerImpl({required this.prefs});

  @override
  UserInfoModel? get getUserInfo {
    final data = prefs.getString(Keys.user);
    return data == null ? null : UserInfoModel.fromJson(jsonDecode(data));
  }

  @override
  Future<void> setUserInfo(UserInfoModel user) async => await prefs.setString(Keys.user, jsonEncode(user.toJson()));

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

  @override
  bool get isBiometric => prefs.getBool(Keys.biometric) ?? false;

  @override
  Future<void> setBiometric(bool value) async => await prefs.setBool(Keys.biometric, value);

  @override
  Future<void> remove(String key) async => await prefs.remove(key);

  @override
  AutoLockTimeType get getAutoLockTime =>
      AutoLockTimeType.getObj(prefs.getString(Keys.autoLockTime) ?? AutoLockTimeType.after10Seconds.key);

  @override
  Future<void> setAutoLockTime(AutoLockTimeType value) async => await prefs.setString(Keys.autoLockTime, value.key);

  @override
  AppConfigModel? get getAppConfig {
    final data = prefs.getString(Keys.appConfig);
    return data == null ? null : AppConfigModel.fromJson(jsonDecode(data));
  }

  @override
  Future<void> setAppConfig(AppConfigModel value) async => await prefs.setString(Keys.appConfig, jsonEncode(value.toJson()));
}
