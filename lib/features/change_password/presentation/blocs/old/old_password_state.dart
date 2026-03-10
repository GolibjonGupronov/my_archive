import 'package:my_archive/core/core_exports.dart';

class OldPasswordState {
  final StateStatus passwordStatus;
  final String errorMessage;
  final bool isActive;
  final String password;

  OldPasswordState({
    this.passwordStatus = StateStatus.initial,
    this.errorMessage = '',
    this.isActive = false,
    this.password = '',
  });

  OldPasswordState copyWith({
    StateStatus? passwordStatus,
    String? errorMessage,
    bool? isActive,
    String? password,
  }) =>
      OldPasswordState(
        passwordStatus: passwordStatus ?? this.passwordStatus,
        errorMessage: errorMessage ?? this.errorMessage,
        isActive: isActive ?? this.isActive,
        password: password ?? this.password,
      );
}
