import 'package:my_archive/core/core_exports.dart';

class AppLockState {
  final StateStatus appLockStatus;
  final StateStatus checkOldPinStatus;
  final bool isActive;
  // final String pinCode;
  final bool isNewPinCode;
  final String errorMessage;

  AppLockState({
    this.appLockStatus = StateStatus.initial,
    this.checkOldPinStatus = StateStatus.initial,
    this.isActive = false,
    // this.pinCode = '',
    this.isNewPinCode = true,
    this.errorMessage = '',
  });

  AppLockState copyWith({
    StateStatus? appLockStatus,
    StateStatus? checkOldPinStatus,
    bool? isActive,
    // String? pinCode,
    bool? isNewPinCode,
    String? errorMessage,
  }) =>
      AppLockState(
        appLockStatus: appLockStatus ?? this.appLockStatus,
        checkOldPinStatus: checkOldPinStatus ?? this.checkOldPinStatus,
        isActive: isActive ?? this.isActive,
        // pinCode: pinCode ?? this.pinCode,
        isNewPinCode: isNewPinCode ?? this.isNewPinCode,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
