import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/edit_profile/data/data_sources/edit_profile_data_source.dart';
import 'package:my_archive/features/edit_profile/data/repositories/edit_profile_repository_impl.dart';
import 'package:my_archive/features/edit_profile/domain/repositories/edit_profile_repository.dart';
import 'package:my_archive/features/edit_profile/domain/use_cases/edit_profile_use_case.dart';

void initEditProfileInjection() {
  sl.registerSingleton<EditProfileDataSource>(EditProfileDataSourceImpl(dio: sl()));
  sl.registerSingleton<EditProfileRepository>(EditProfileRepositoryImpl(profileDataSource: sl()));
  sl.registerSingleton<EditProfileUseCase>(EditProfileUseCase(repository: sl()));
}
