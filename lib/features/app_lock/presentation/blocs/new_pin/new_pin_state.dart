import 'package:my_archive/core/core_exports.dart';

class NewPinState {
  final StateStatus appLockStatus;
  final bool isActive;

  NewPinState({
    this.appLockStatus = StateStatus.initial,
    this.isActive = false,
  });

  NewPinState copyWith({
    StateStatus? appLockStatus,
    bool? isActive,
  }) =>
      NewPinState(
        appLockStatus: appLockStatus ?? this.appLockStatus,
        isActive: isActive ?? this.isActive,
      );
}
