import 'package:my_archive/core/core_exports.dart';

class RegSmsState {
  final StateStatus regStatus;
  final StateStatus resendPhoneStatus;
  final String code;
  final bool isActive;
  final int second;
  final String errorMessage;

  RegSmsState({
    this.regStatus = StateStatus.initial,
    this.resendPhoneStatus = StateStatus.initial,
    this.code = '',
    this.isActive = false,
    this.second = Constants.smsResendPhoneSecond,
    this.errorMessage = '',
  });

  RegSmsState copyWith({
    StateStatus? regStatus,
    StateStatus? resendPhoneStatus,
    String? code,
    bool? isActive,
    int? second,
    String? errorMessage,
  }) =>
      RegSmsState(
        regStatus: regStatus ?? this.regStatus,
        resendPhoneStatus: resendPhoneStatus ?? this.resendPhoneStatus,
        code: code ?? this.code,
        isActive: isActive ?? this.isActive,
        second: second ?? this.second,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
