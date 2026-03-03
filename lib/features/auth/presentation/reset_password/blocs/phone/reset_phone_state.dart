import 'package:my_archive/core/core_exports.dart';

class ResetPhoneState {
  final StateStatus phoneStatus;
  final String errorMessage;
  final bool isActive;
  final String phone;

  ResetPhoneState({
    this.phoneStatus = StateStatus.initial,
    this.errorMessage = '',
    this.isActive = false,
    this.phone = '',
  });

  ResetPhoneState copyWith({
    StateStatus? phoneStatus,
    String? errorMessage,
    bool? isActive,
    String? phone,
  }) =>
      ResetPhoneState(
        phoneStatus: phoneStatus ?? this.phoneStatus,
        errorMessage: errorMessage ?? this.errorMessage,
        isActive: isActive ?? this.isActive,
        phone: phone ?? this.phone,
      );
}