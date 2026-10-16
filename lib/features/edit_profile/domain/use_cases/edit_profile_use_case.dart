import 'package:my_archive/core/exports/domain_exports.dart';
import 'package:my_archive/features/edit_profile/domain/repositories/edit_profile_repository.dart';

class EditProfileUseCase extends UseCase<bool, EditProfileParams> {
  final EditProfileRepository repository;

  EditProfileUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> callUseCase(EditProfileParams params) => repository.editProfile(params);
}
