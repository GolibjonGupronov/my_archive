import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/auth/domain/use_cases/registration_use_case.dart';
import 'package:my_archive/features/auth/domain/use_cases/send_phone_use_case.dart';
import 'package:my_archive/features/auth/presentation/registration/blocs/sms/reg_sms_event.dart';
import 'package:my_archive/features/auth/presentation/registration/blocs/sms/reg_sms_state.dart';

class RegSmsBloc extends Bloc<RegSmsEvent, RegSmsState> {
  final RegistrationUseCase registrationUseCase;
  final SendPhoneUseCase sendPhoneUseCase;
  Timer? _timer;
  int _seconds = Constants.smsResendPhoneSecond;

  RegSmsBloc({required this.registrationUseCase, required this.sendPhoneUseCase}) : super(RegSmsState()) {
    on<InitEvent>((event, emit) {
      add(StartTimerEvent());
    });

    on<StartTimerEvent>((event, emit) {
      _seconds = Constants.smsResendPhoneSecond;
      emit(state.copyWith(second: _seconds));
      _startTimer();
    });

    on<UpdateFieldEvent>((event, emit) async {
      final code = event.code ?? state.code;

      emit(state.copyWith(code: code, isActive: code.length == Constants.smsCodeLength));
    });

    on<SubmitEvent>(_submit);

    on<ResendPhoneEvent>(_resend);

    on<SecondEvent>((event, emit) {
      emit(state.copyWith(second: event.second));
    });
  }

  Future<void> _submit(SubmitEvent event, Emitter<RegSmsState> emit) async {
    emit(state.copyWith(regStatus: StateStatus.inProgress));
    final resultSms = await registrationUseCase.callUseCase(event.params);
    await resultSms.fold(
      (fail) async => emit(state.copyWith(regStatus: StateStatus.failure, errorMessage: fail.message)),
      (data) async {
        _timer?.cancel();
        emit(state.copyWith(regStatus: StateStatus.success));
      },
    );
  }

  Future<void> _resend(ResendPhoneEvent event, Emitter<RegSmsState> emit) async {
    emit(state.copyWith(resendPhoneStatus: StateStatus.inProgress));
    final result = await sendPhoneUseCase.callUseCase(event.phone);
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
