import 'package:my_archive/core/enums/lang_type.dart';
import 'package:my_archive/core/local_storage/pref_manager/base_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefManager extends BasePrefs {
  PrefManager._(super.prefs);

  static PrefManager? _instance;

  static const String _token = 'token';
  static const String _user = 'user';
  static const String _language = 'language';

  static Future<PrefManager> init() async {
    final prefs = await SharedPreferences.getInstance();
    _instance = PrefManager._(prefs);
    return _instance!;
  }

  static PrefManager get _i {
    if (_instance == null) {
      throw Exception('PrefManager not initialized');
    }
    return _instance!;
  }

  String get getToken => _i.getString(_token);

  Future<bool> setToken(String value) async => await _i.setString(_token, value);

  // UserInfo get getUserData => _i.getObject(_user, (json) => UserInfo.fromJson(json));
  //
  // Future<bool> setUserData(UserInfo user) => _i.setObject(_user, user, (user) => user.toJson());

  LangType get getLanguage => LangType.getObj(_i.getString(_language, defaultValue: LangType.uz.key));

  Future<bool> setLanguage(LangType lang) async => await _i.setString(_language, lang.key);

  static Future<void> clearAll() async {
    await _i.prefs.clear();
  }
}
