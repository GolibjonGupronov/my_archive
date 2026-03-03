import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/auth/domain/use_cases/registration_use_case.dart';

class RegistrationState {
  final StateStatus regStatus;
  final String firstName;
  final String secondName;
  final Gender gender;
  final DateTime? birthDay;
  final bool isActive;
  final String errorMessage;
  final String phone;
  final RegistrationParams? params;

  RegistrationState({
    this.regStatus = StateStatus.initial,
    this.firstName = '',
    this.secondName = '',
    this.gender = Gender.male,
    this.birthDay,
    this.isActive = false,
    this.errorMessage = '',
    this.phone = '',
    this.params,
  });

  RegistrationState copyWith({
    StateStatus? regStatus,
    String? firstName,
    String? secondName,
    Gender? gender,
    DateTime? birthDay,
    bool? isActive,
    String? errorMessage,
    String? phone,
    RegistrationParams? params,
  }) =>
      RegistrationState(
        regStatus: regStatus ?? this.regStatus,
        firstName: firstName ?? this.firstName,
        secondName: secondName ?? this.secondName,
        gender: gender ?? this.gender,
        birthDay: birthDay ?? this.birthDay,
        isActive: isActive ?? this.isActive,
        errorMessage: errorMessage ?? this.errorMessage,
        phone: phone ?? this.phone,
        params: params ?? this.params,
      );
}
