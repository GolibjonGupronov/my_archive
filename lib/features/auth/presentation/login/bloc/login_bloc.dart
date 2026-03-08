import 'package:bloc/bloc.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/auth/domain/use_cases/login_use_case.dart';
import 'package:my_archive/features/auth/domain/use_cases/user_info_use_case.dart';

import 'package:my_archive/features/auth/presentation/login/bloc/login_event.dart';
import 'package:my_archive/features/auth/presentation/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  final UserInfoUseCase userInfoUseCase;

  LoginBloc({required this.loginUseCase, required this.userInfoUseCase}) : super(LoginState()) {
    on<InitEvent>((event, emit) {});

    on<UpdateFieldEvent>((event, emit) {
      final phone = event.phone ?? state.phone;
      final password = event.password ?? state.password;
      final phoneDigits = phone.replaceAll(RegExp(r'\D'), '');
      final isActive = phoneDigits.length == 9 && password.length >= Constants.passwordLength;
      emit(state.copyWith(phone: phone, password: password, isActive: isActive));
    });

    on<SubmitEvent>(_submit);
  }

  Future<void> _submit(SubmitEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(loginStatus: StateStatus.inProgress));
    final result = await loginUseCase.callUseCase(event.params);
    await result.fold((fail) async {
      emit(state.copyWith(loginStatus: StateStatus.failure, errorMessage: fail.message));
    }, (data) async {
      if (data.isNotEmpty) {
        final resultUser = await userInfoUseCase.callUseCase(NoParams());
        resultUser.fold((fail) {
          emit(state.copyWith(loginStatus: StateStatus.failure, errorMessage: fail.message));
        }, (data) {
          emit(state.copyWith(loginStatus: StateStatus.success));
        });
      } else {
        emit(state.copyWith(loginStatus: StateStatus.failure, errorMessage: "Token bo'sh"));
      }
    });
  }
}
