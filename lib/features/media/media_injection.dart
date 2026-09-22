import 'package:my_archive/core/di/injection_container.dart';
import 'package:my_archive/features/media/data/data_sources/firebase_media_data_source_impl.dart';
import 'package:my_archive/features/media/data/data_sources/media_data_source.dart';
import 'package:my_archive/features/media/data/repositories/media_repository_impl.dart';
import 'package:my_archive/features/media/domain/repositories/media_repository.dart';
import 'package:my_archive/features/media/domain/use_cases/media_use_case.dart';

class MediaInjection {
  static void init() {
    sl.registerSingleton<MediaDataSource>(FirebaseMediaDataSourceImpl(firestore: sl(), secureStorage: sl()));
    // sl.registerSingleton<MediaDataSource>(MediaDataSourceImpl(dio: sl()));
    sl.registerSingleton<MediaRepository>(MediaRepositoryImpl(mediaDataSource: sl()));
    sl.registerSingleton<MediaUseCase>(MediaUseCase(repository: sl()));
  }
}
