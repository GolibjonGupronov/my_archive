import 'package:bloc/bloc.dart';
import 'package:my_archive/features/auth/domain/entities/password_check_entity.dart';

import 'new_password_event.dart';
import 'new_password_state.dart';

class NewPasswordBloc extends Bloc<NewPasswordEvent, NewPasswordState> {
  NewPasswordBloc() : super(NewPasswordState()) {
    on<InitEvent>((event, emit) {});
    on<UpdateFieldEvent>((event, emit) {
      final newPassword = event.newPassword ?? state.password;
      final againPassword = event.againNewPassword ?? state.againPassword;

      final check = _validatePassword(newPassword);

      final isActive = newPassword.isNotEmpty &&
          againPassword.isNotEmpty &&
          newPassword == againPassword &&
          check.upperText &&
          check.lowerText &&
          check.number &&
          check.char &&
          check.length;

      emit(state.copyWith(checkText: check, isActive: isActive, password: newPassword, againPassword: againPassword));
    });
  }

  PasswordCheckEntity _validatePassword(String password) {
    return PasswordCheckEntity(
      upperText: RegExp(r'[A-Z]').hasMatch(password),
      lowerText: RegExp(r'[a-z]').hasMatch(password),
      number: RegExp(r'[0-9]').hasMatch(password),
      char: RegExp(r'''[!@#$%^&*(),.?\":{}|<>]''').hasMatch(password),
      length: password.length >= 8,
    );
  }
}
