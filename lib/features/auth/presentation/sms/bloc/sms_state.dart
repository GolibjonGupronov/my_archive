import 'package:my_archive/core/enums/state_status.dart';
import 'package:my_archive/features/auth/domain/entities/user_info_entity.dart';

class SmsState {
  final StateStatus smsStatus;
  final UserInfoEntity? userInfo;
  final String errorMessage;

  SmsState({
    this.smsStatus = StateStatus.initial,
    this.userInfo,
    this.errorMessage = '',
  });

  SmsState copyWith({
    StateStatus? smsStatus,
    UserInfoEntity? userInfo,
    String? errorMessage,
  }) =>
      SmsState(
        smsStatus: smsStatus ?? this.smsStatus,
        userInfo: userInfo ?? this.userInfo,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
