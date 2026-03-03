import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/auth/domain/entities/password_check_entity.dart';

class NewPasswordState {
  final StateStatus passwordStatus;
  final String errorMessage;
  final bool isActive;
  final String password;
  final String againPassword;
  final PasswordCheckEntity checkText;

  NewPasswordState({
    this.passwordStatus = StateStatus.initial,
    this.errorMessage = '',
    this.isActive = false,
    this.password = '',
    this.againPassword = '',
    this.checkText = const PasswordCheckEntity(),
  });

  NewPasswordState copyWith({
    StateStatus? passwordStatus,
    String? errorMessage,
    bool? isActive,
    String? password,
    String? againPassword,
    PasswordCheckEntity? checkText,
  }) =>
      NewPasswordState(
        passwordStatus: passwordStatus ?? this.passwordStatus,
        errorMessage: errorMessage ?? this.errorMessage,
        isActive: isActive ?? this.isActive,
        password: password ?? this.password,
        againPassword: againPassword ?? this.againPassword,
        checkText: checkText ?? this.checkText,
      );
}
