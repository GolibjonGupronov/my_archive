import 'package:my_archive/core/core_exports.dart';

class ResetSmsState {
  final StateStatus smsStatus;
  final StateStatus resendPhoneStatus;
  final String code;
  final bool isActive;
  final int second;
  final String errorMessage;

  ResetSmsState({
    this.smsStatus = StateStatus.initial,
    this.resendPhoneStatus = StateStatus.initial,
    this.code = '',
    this.isActive = false,
    this.second = Constants.smsResendPhoneSecond,
    this.errorMessage = '',
  });

  ResetSmsState copyWith({
    StateStatus? smsStatus,
    StateStatus? resendPhoneStatus,
    String? code,
    bool? isActive,
    int? second,
    String? errorMessage,
  }) =>
      ResetSmsState(
        smsStatus: smsStatus ?? this.smsStatus,
        resendPhoneStatus: resendPhoneStatus ?? this.resendPhoneStatus,
        code: code ?? this.code,
        isActive: isActive ?? this.isActive,
        second: second ?? this.second,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
