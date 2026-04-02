import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/core/di/injection_exports.dart';
import 'package:my_archive/core/local_storage/secure_storage.dart';
import 'package:my_archive/features/faq/faq_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

class InjectionContainer {
  static Future<void> init() async {
    await _env();
    await _prefManager();
    _secureStorage();
    await _dio();
    await _injections();
  }

  static Future<void> _env() async {
    await dotenv.load(fileName: ".env");
  }

  static Future<void> _prefManager() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);
    sl.registerLazySingleton<PrefManager>(() => PrefManagerImpl(prefs: sl()));
  }

  static void _secureStorage() async {
    sl.registerLazySingleton(() => const FlutterSecureStorage());
    sl.registerLazySingleton<SecureStorage>(() => SecureStorageImpl(storage: sl()));
  }

  static Future<void> _dio() async {
    sl.registerLazySingleton<Dio>(() => DioSetting.create());
  }

  static Future<void> _injections() async {
    initSplashInjection();
    initAuthInjection();
    initChangePasswordInjection();
    initProfileInjection();
    initFaqInjection();
    initStoryInjection();
    initDeviceSessionInjection();
  }
}
