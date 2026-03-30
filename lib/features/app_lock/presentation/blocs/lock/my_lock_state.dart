import 'package:my_archive/core/core_exports.dart';

class MyLockState {
  final StateStatus pinStatus;
  final bool isBiometricEnabled;
  final bool hasPin;

  MyLockState({
    this.pinStatus = StateStatus.initial,
    this.isBiometricEnabled = false,
    this.hasPin = true,
  });

  MyLockState copyWith({
    StateStatus? pinStatus,
    bool? isBiometricEnabled,
    bool? hasPin,
  }) =>
      MyLockState(
        pinStatus: pinStatus ?? this.pinStatus,
        isBiometricEnabled: isBiometricEnabled ?? this.isBiometricEnabled,
        hasPin: hasPin ?? this.hasPin,
      );
}
