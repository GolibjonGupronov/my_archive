import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/auth/domain/use_cases/registration_use_case.dart';
import 'package:my_archive/features/auth/domain/use_cases/send_phone_use_case.dart';
import 'package:my_archive/features/auth/domain/use_cases/user_info_use_case.dart';
import 'package:my_archive/features/auth/presentation/registration/bloc/registration_event.dart';
import 'package:my_archive/features/auth/presentation/registration/bloc/registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final SendPhoneUseCase sendPhoneUseCase;
  final RegistrationUseCase registrationUseCase;
  final UserInfoUseCase userInfoUseCase;
  Timer? _timer;
  int _seconds = Constants.smsResendPhoneSecond;

  RegistrationBloc({required this.sendPhoneUseCase, required this.registrationUseCase, required this.userInfoUseCase})
      : super(RegistrationState()) {
    on<InitEvent>((event, emit) {
      add(StartTimerEvent());
    });
    on<StartTimerEvent>((event, emit) {
      _seconds = Constants.smsResendPhoneSecond;
      emit(state.copyWith(second: _seconds));
      _startTimer();
    });
    on<ResendPhoneEvent>((event, emit) async {
      await _resend(emit, event.phone);
    });
    on<SecondEvent>((event, emit) {
      emit(state.copyWith(second: event.second));
    });

    on<SubmitEvent>((event, emit) async {
      await _submit(event, emit);
    });

    on<UpdateFieldEvent>((event, emit) async {
      final code = event.code ?? state.code;
      final firstName = event.firstName ?? state.firstName;
      final secondName = event.secondName ?? state.secondName;
      final birthDay = event.birthDay ?? state.birthDay;
      final gender = event.gender ?? state.gender;
      final isActive = code.length == Constants.smsCodeLength &&
          birthDay != null &&
          firstName.trim().isNotEmpty &&
          secondName.trim().isNotEmpty;

      emit(state.copyWith(
          code: code, firstName: firstName, secondName: secondName, birthDay: birthDay, gender: gender, isActive: isActive));
    });
  }

  Future<void> _submit(SubmitEvent event, Emitter<RegistrationState> emit) async {
    emit(state.copyWith(regStatus: StateStatus.inProgress));
    final result = await registrationUseCase.callUseCase(event.params);
    await result.fold((fail) async => emit(state.copyWith(regStatus: StateStatus.failure, errorMessage: fail.message)),
        (data) async {
      if (data.isNotEmpty) {
        final resultUser = await userInfoUseCase.callUseCase(NoParams());
        resultUser.fold((fail) {
          emit(state.copyWith(regStatus: StateStatus.failure, errorMessage: fail.message));
        }, (data) {
          _timer?.cancel();
          emit(state.copyWith(regStatus: StateStatus.success));
        });
      } else {
        emit(state.copyWith(regStatus: StateStatus.failure, errorMessage: "Token bo'sh"));
      }
    });
  }

  Future<void> _resend(Emitter<RegistrationState> emit, String phone) async {
    emit(state.copyWith(resendPhoneStatus: StateStatus.inProgress));
    final result = await sendPhoneUseCase.callUseCase(phone);
    result.fold((fail) {
      emit(state.copyWith(resendPhoneStatus: StateStatus.failure, errorMessage: fail.message));
    }, (isRegistered) {
      add(StartTimerEvent());
      emit(state.copyWith(resendPhoneStatus: StateStatus.success));
    });
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds <= 0) {
        timer.cancel();
        add(SecondEvent(second: 0));
      } else {
        _seconds--;
        add(SecondEvent(second: _seconds));
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
