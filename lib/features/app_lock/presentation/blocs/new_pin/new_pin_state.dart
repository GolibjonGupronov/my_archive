import 'package:my_archive/core/core_exports.dart';

class NewPinState {
  final StateStatus appLockStatus;
  final bool isActive;
  final String newPinCode;
  final String errorMessage;

  NewPinState({
    this.appLockStatus = StateStatus.initial,
    this.isActive = false,
    this.newPinCode = "",
    this.errorMessage = ""
  });

  NewPinState copyWith({
    StateStatus? appLockStatus,
    bool? isActive,
    String? newPinCode,
    String? errorMessage,
  }) =>
      NewPinState(
        appLockStatus: appLockStatus ?? this.appLockStatus,
        isActive: isActive ?? this.isActive,
        newPinCode: newPinCode ?? this.newPinCode,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
