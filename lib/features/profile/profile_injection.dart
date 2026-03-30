import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/profile/data/data_sources/profile_data_source.dart';
import 'package:my_archive/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:my_archive/features/profile/domain/repositories/profile_repository.dart';
import 'package:my_archive/features/profile/domain/use_cases/change_image_use_case.dart';
import 'package:my_archive/features/profile/domain/use_cases/edit_profile_use_case.dart';
import 'package:my_archive/features/profile/domain/use_cases/enable_notification_use_case.dart';

void initProfileInjection() {
  sl.registerSingleton<ProfileDataSource>(ProfileDataSourceImpl(dio: sl()));
  sl.registerSingleton<ProfileRepository>(ProfileRepositoryImpl(profileDataSource: sl()));
  sl.registerSingleton<ChangeImageUseCase>(ChangeImageUseCase(repository: sl()));
  sl.registerSingleton<EditProfileUseCase>(EditProfileUseCase(repository: sl()));
  sl.registerSingleton<EnableNotificationUseCase>(EnableNotificationUseCase(repository: sl()));
}
