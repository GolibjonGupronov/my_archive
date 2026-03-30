import 'package:my_archive/core/core_exports.dart';

class AppLockState {
  final StateStatus lockStatus;
  final bool isActive;
  final String errorMessage;

  AppLockState({
    this.lockStatus = StateStatus.initial,
    this.isActive = false,
    this.errorMessage = '',
  });

  AppLockState copyWith({
    StateStatus? lockStatus,
    bool? isActive,
    String? errorMessage,
  }) =>
      AppLockState(
        lockStatus: lockStatus ?? this.lockStatus,
        isActive: isActive ?? this.isActive,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
