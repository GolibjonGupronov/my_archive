import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/profile/domain/repositories/profile_repository.dart';

class EditProfileUseCase extends UseCase<bool, EditProfileParams> {
  final ProfileRepository repository;

  EditProfileUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> callUseCase(EditProfileParams params) async => await repository.editProfile(params);
}

class EditProfileParams {
  final String firstName;
  final String secondName;
  final Gender gender;
  final DateTime birthDay;

  const EditProfileParams({
    required this.firstName,
    required this.secondName,
    required this.gender,
    required this.birthDay,
  });

  Map<String, dynamic> get toMap => {
        'first_name': firstName,
        'second_name': secondName,
        'gender': gender.key,
        'birth_day': birthDay.toBackendDate,
      };
}
