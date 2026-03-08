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

  final bool isChanged;
  final String initialFirstName;
  final String initialSecondName;
  final Gender initialGender;
  final DateTime? initialBirthDay;

  const EditProfileState({
    this.editStatus = StateStatus.initial,
    this.firstName = '',
    this.secondName = '',
    this.gender = Gender.male,
    this.birthDay,
    this.isActive = false,
    this.errorMessage = '',
    this.phone = '',
    this.isChanged = false,
    this.initialFirstName = '',
    this.initialSecondName = '',
    this.initialBirthDay,
    this.initialGender = Gender.male,
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
    bool? isChanged,
    String? initialFirstName,
    String? initialSecondName,
    Gender? initialGender,
    DateTime? initialBirthDay,
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
        isChanged: isChanged ?? this.isChanged,
        initialFirstName: initialFirstName ?? this.initialFirstName,
        initialSecondName: initialSecondName ?? this.initialSecondName,
        initialGender: initialGender ?? this.initialGender,
        initialBirthDay: initialBirthDay ?? this.initialBirthDay,
      );
}
