import 'package:my_archive/core/enums/state_status.dart';
import 'package:my_archive/features/auth/domain/entities/send_phone_response_entity.dart';

class PhoneState {
  final StateStatus phoneStatus;
  final String errorMessage;
  final SendPhoneResponseEntity? data;


  PhoneState({
    this.phoneStatus = StateStatus.initial,
    this.errorMessage = '',
    this.data
  });

  PhoneState copyWith({
    StateStatus? phoneStatus,
    String? errorMessage,
    SendPhoneResponseEntity? data,
  }) =>
      PhoneState(
        phoneStatus: phoneStatus ?? this.phoneStatus,
        errorMessage: errorMessage ?? this.errorMessage,
        data: data ?? this.data,
      );
}
