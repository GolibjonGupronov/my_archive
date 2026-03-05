import 'package:my_archive/core/core_exports.dart';

class EditProfileState {
  final StateStatus editStatus;
  final String firstName;
  final String secondName;
  final Gender gender;
  final DateTime? birthDay;
  final bool isActive;
  final String errorMessage;
  final String phone;

  EditProfileState({
    this.editStatus = StateStatus.initial,
    this.firstName = '',
    this.secondName = '',
    this.gender = Gender.male,
    this.birthDay,
    this.isActive = false,
    this.errorMessage = '',
    this.phone = '',
  });

  EditProfileState copyWith({
    StateStatus? editStatus,
    String? firstName,
    String? secondName,
    Gender? gender,
    DateTime? birthDay,
    bool? isActive,
    String? errorMessage,
    String? phone,
  }) =>
      EditProfileState(
        editStatus: editStatus ?? this.editStatus,
        firstName: firstName ?? this.firstName,
        secondName: secondName ?? this.secondName,
        gender: gender ?? this.gender,
        birthDay: birthDay ?? this.birthDay,
        isActive: isActive ?? this.isActive,
        errorMessage: errorMessage ?? this.errorMessage,
        phone: phone ?? this.phone,
      );
}