import 'package:bloc/bloc.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/auth/domain/entities/password_check_entity.dart';
import 'package:my_archive/features/auth/domain/use_cases/new_password_use_case.dart';

import 'new_password_event.dart';
import 'new_password_state.dart';

class NewPasswordBloc extends Bloc<NewPasswordEvent, NewPasswordState> {
  final NewPasswordUseCase newPasswordUseCase;
  final PrefManager prefManager;

  NewPasswordBloc({required this.newPasswordUseCase, required this.prefManager}) : super(NewPasswordState()) {
    on<InitEvent>((event, emit) {});

    on<SubmitEvent>((event, emit) async {
      await _submit(event, emit);
    });

    on<UpdateFieldEvent>((event, emit) {
      final newPassword = event.newPassword ?? state.password;
      final againPassword = event.againNewPassword ?? state.againPassword;

      final check = _validatePassword(newPassword);

      final isActive = newPassword.trim().isNotEmpty &&
          againPassword.trim().isNotEmpty &&
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

  Future<void> _submit(SubmitEvent event, Emitter<NewPasswordState> emit) async {
    emit(state.copyWith(passwordStatus: StateStatus.inProgress));
    final result = await newPasswordUseCase.callUseCase(event.password);
    result.fold((fail) {
      emit(state.copyWith(passwordStatus: StateStatus.failure, errorMessage: fail.message));
    }, (data) {
      prefManager.setToken('');
      emit(state.copyWith(passwordStatus: StateStatus.success));
    });
  }
}
