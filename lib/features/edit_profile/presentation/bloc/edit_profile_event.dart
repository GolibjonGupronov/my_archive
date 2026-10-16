import 'package:my_archive/core/enums/common.dart';
import 'package:my_archive/core/params/edit_profil_params.dart';

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

class CanEditEvent extends EditProfileEvent {}
