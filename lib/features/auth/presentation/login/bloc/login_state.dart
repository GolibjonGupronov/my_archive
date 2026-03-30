import 'package:my_archive/core/core_exports.dart';

class LoginState {
  final StateStatus loginStatus;
  final String errorMessage;
  final bool isActive;
  final String phone;
  final String password;
  final bool hasPin;

  LoginState({
    this.loginStatus = StateStatus.initial,
    this.errorMessage = '',
    this.isActive = false,
    this.phone = '',
    this.password = '',
    this.hasPin = false,
  });

  LoginState copyWith({
    StateStatus? loginStatus,
    String? errorMessage,
    bool? isActive,
    String? phone,
    String? password,
    bool? hasPin,
  }) =>
      LoginState(
        loginStatus: loginStatus ?? this.loginStatus,
        errorMessage: errorMessage ?? this.errorMessage,
        isActive: isActive ?? this.isActive,
        phone: phone ?? this.phone,
        password: password ?? this.password,
        hasPin: hasPin ?? this.hasPin,
      );
}
