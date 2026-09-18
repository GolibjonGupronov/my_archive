import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:my_archive/core/api/dio/dio_setting.dart';
import 'package:my_archive/core/exports/injection_exports.dart';
import 'package:my_archive/core/local_storage/pref_manager.dart';
import 'package:my_archive/core/local_storage/secure_storage.dart';
import 'package:my_archive/core/services/video_compressor/video_compressor_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

class InjectionContainer {
  static Future<void> init() async {
    await _env();
    await _prefManager();
    _secureStorage();
    _dio();
    _firebase();
    _service();
    _injections();
  }

  static Future<void> _env() async {
    await dotenv.load(fileName: ".env");
  }

  static Future<void> _prefManager() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);
    sl.registerLazySingleton<PrefManager>(() => PrefManagerImpl(prefs: sl()));
  }

  static void _secureStorage() {
    sl.registerLazySingleton(() => const FlutterSecureStorage());
    sl.registerLazySingleton<SecureStorage>(() => SecureStorageImpl(storage: sl()));
  }

  static void _dio() {
    sl.registerLazySingleton<Dio>(() => DioSetting.create());
  }

  static void _firebase() {
    sl.registerLazySingleton(() => FirebaseAuth.instance);
    sl.registerLazySingleton(() => FirebaseFirestore.instance);
    // sl.registerLazySingleton(() => FirebaseStorage.instance);
    // sl.registerLazySingleton(() => FirebaseMessaging.instance);
  }

  static void _service() {
    sl.registerLazySingleton<VideoCompressorService>(() => VideoCompressorService(dio: sl()));
  }

  static void _injections() {
    initSplashInjection();
    initMainInjection();
    initAuthInjection();
    initChangePasswordInjection();
    initProfileInjection();
    initFaqInjection();
    initEditProfileInjection();
    initStoryInjection();
    initDeviceSessionInjection();
  }
}
