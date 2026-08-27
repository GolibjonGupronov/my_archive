import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/main/data/data_sources/firebase_main_data_source_impl.dart';
import 'package:my_archive/features/main/data/data_sources/main_data_source.dart';
import 'package:my_archive/features/main/data/data_sources/main_data_source_impl.dart';
import 'package:my_archive/features/main/data/repositories/main_repository_impl.dart';
import 'package:my_archive/features/main/domain/repositories/main_repository.dart';
import 'package:my_archive/features/main/domain/use_cases/check_session_use_case.dart';

void initMainInjection(){
  sl.registerSingleton<MainDataSource>(FirebaseMainDataSourceImpl(firestore: sl(), secureStorage: sl()));
  // sl.registerSingleton<MainDataSource>(MainDataSourceImpl(dio: sl()));
  sl.registerSingleton<MainRepository>(MainRepositoryImpl(mainDataSource: sl()));
  sl.registerSingleton<CheckSessionUseCase>(CheckSessionUseCase(repository: sl()));
}