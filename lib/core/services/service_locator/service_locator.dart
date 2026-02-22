import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:my_archive/core/api/dio/dio_setting.dart';
import 'package:my_archive/core/local_storage/pref_manager/pref_manager.dart';
import 'package:my_archive/core/services/service_locator/injection_exports.dart';

final GetIt sl = GetIt.instance;

class LocatorDi{
  static Future<void> init() async {
    await _clear();
    await _provideEnv();
    await _providePrefManager();
    await _provideDio();
    await _provideInit();
  }

  static Future<void> _provideEnv() async {
    await dotenv.load(fileName: ".env");
  }

  static Future<void> _providePrefManager() async {
    final pref = await PrefManager.init();
    sl.registerLazySingleton(() => pref);
  }

  static Future<void> _provideDio() async {
    sl.registerLazySingleton<Dio>(() => DioSetting.create());
  }

  static Future<void> _provideInit() async {
    initSplashInjection();
    initAuthInjection();
  }

  static Future<void> _clear() async {
    await sl.reset();
  }
}