import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/edit_profile/domain/use_cases/edit_profile_use_case.dart';

abstract class EditProfileEvent {}

class InitEvent extends EditProfileEvent {
  final String? firstName;
  final String? secondName;
  final DateTime? birthDay;
  final Gender? gender;

  InitEvent({
    required this.firstName,
    required this.secondName,
    required this.birthDay,
    required this.gender,
  });
}

class SubmitEvent extends EditProfileEvent {
  final EditProfileParams params;

  SubmitEvent({required this.params});
}

class UpdateFieldEvent extends EditProfileEvent {
  final String? firstName;
  final String? secondName;
  final Gender? gender;
  final DateTime? birthDay;

  UpdateFieldEvent({
    this.firstName,
    this.secondName,
    this.gender,
    this.birthDay,
  });
}
