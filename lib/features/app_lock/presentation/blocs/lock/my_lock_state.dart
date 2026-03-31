import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/app_lock/presentation/widgets/auto_lock_widget.dart';

class MyLockState {
  final StateStatus pinStatus;
  final bool isBiometricEnabled;
  final bool hasPin;
  final AutoLockTimeType autoLockTime;

  MyLockState({
    this.pinStatus = StateStatus.initial,
    this.isBiometricEnabled = false,
    this.hasPin = true,
    this.autoLockTime = AutoLockTimeType.immediately,
  });

  MyLockState copyWith({
    StateStatus? pinStatus,
    bool? isBiometricEnabled,
    bool? hasPin,
    AutoLockTimeType? autoLockTime,
  }) =>
      MyLockState(
        pinStatus: pinStatus ?? this.pinStatus,
        isBiometricEnabled: isBiometricEnabled ?? this.isBiometricEnabled,
        hasPin: hasPin ?? this.hasPin,
        autoLockTime: autoLockTime ?? this.autoLockTime,
      );
}
