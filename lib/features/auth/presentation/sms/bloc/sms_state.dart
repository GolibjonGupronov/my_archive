import 'package:my_archive/core/constants/constants.dart';
import 'package:my_archive/core/enums/state_status.dart';
import 'package:my_archive/features/auth/domain/entities/user_info_entity.dart';

class SmsState {
  final StateStatus smsStatus;
  final StateStatus resendPhoneStatus;
  final String code;
  final bool isActive;
  final int second;
  final String errorMessage;

  SmsState({
    this.smsStatus = StateStatus.initial,
    this.resendPhoneStatus = StateStatus.initial,
    this.code = '',
    this.isActive = false,
    this.second = Constants.smsResendPhoneSecond,
    this.errorMessage = '',
  });

  SmsState copyWith({
    StateStatus? smsStatus,
    StateStatus? resendPhoneStatus,
    String? code,
    bool? isActive,
    int? second,
    String? errorMessage,
  }) =>
      SmsState(
        smsStatus: smsStatus ?? this.smsStatus,
        resendPhoneStatus: resendPhoneStatus ?? this.resendPhoneStatus,
        code: code ?? this.code,
        isActive: isActive ?? this.isActive,
        second: second ?? this.second,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
