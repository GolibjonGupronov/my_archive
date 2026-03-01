import 'package:my_archive/core/core_exports.dart';

class RegistrationState {
  final StateStatus regStatus;
  final StateStatus resendPhoneStatus;
  final String firstName;
  final String secondName;
  final Gender gender;
  final DateTime? birthDay;
  final String code;
  final bool isActive;
  final int second;
  final String errorMessage;

  RegistrationState({
    this.regStatus = StateStatus.initial,
    this.resendPhoneStatus = StateStatus.initial,
    this.firstName = '',
    this.secondName = '',
    this.gender = Gender.male,
    this.birthDay,
    this.code = '',
    this.isActive = false,
    this.second = Constants.smsResendPhoneSecond,
    this.errorMessage = '',
  });

  RegistrationState copyWith({
    StateStatus? regStatus,
    StateStatus? resendPhoneStatus,
    String? firstName,
    String? secondName,
    Gender? gender,
    DateTime? birthDay,
    String? code,
    bool? isActive,
    int? second,
    String? errorMessage,
  }) =>
      RegistrationState(
        regStatus: regStatus ?? this.regStatus,
        resendPhoneStatus: resendPhoneStatus ?? this.resendPhoneStatus,
        firstName: firstName ?? this.firstName,
        secondName: secondName ?? this.secondName,
        gender: gender ?? this.gender,
        birthDay: birthDay ?? this.birthDay,
        code: code ?? this.code,
        isActive: isActive ?? this.isActive,
        second: second ?? this.second,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
