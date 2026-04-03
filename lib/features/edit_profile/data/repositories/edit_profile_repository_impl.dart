import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/edit_profile/data/data_sources/edit_profile_data_source.dart';
import 'package:my_archive/features/edit_profile/domain/repositories/edit_profile_repository.dart';
import 'package:my_archive/features/edit_profile/domain/use_cases/edit_profile_use_case.dart';

class EditProfileRepositoryImpl with SafeCaller implements EditProfileRepository {
  final EditProfileDataSource profileDataSource;

  EditProfileRepositoryImpl({required this.profileDataSource});

  @override
  Future<Either<Failure, bool>> editProfile(EditProfileParams params) {
    return safeCall(() async => await profileDataSource.editProfile(params));
  }
}
