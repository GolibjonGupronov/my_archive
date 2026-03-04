import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/auth/domain/use_cases/check_sms_use_case.dart';
import 'package:my_archive/features/auth/domain/use_cases/send_phone_use_case.dart';
import 'package:my_archive/features/auth/presentation/reset_password/blocs/sms/reset_sms_event.dart';
import 'package:my_archive/features/auth/presentation/reset_password/blocs/sms/reset_sms_state.dart';

class ResetSmsBloc extends Bloc<ResetSmsEvent, ResetSmsState> {
  final CheckSmsUseCase checkSmsUseCase;
  final SendPhoneUseCase sendPhoneUseCase;
  Timer? _timer;
  int _seconds = Constants.smsResendPhoneSecond;

  ResetSmsBloc({required this.checkSmsUseCase, required this.sendPhoneUseCase}) : super(ResetSmsState()) {
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

    on<SubmitEvent>((event, emit) async {
      await _submit(event, emit);
    });

    on<ResendPhoneEvent>((event, emit) async {
      await _resend(emit, event.phone);
    });

    on<SecondEvent>((event, emit) {
      emit(state.copyWith(second: event.second));
    });
  }

  Future<void> _submit(SubmitEvent event, Emitter<ResetSmsState> emit) async {
    emit(state.copyWith(smsStatus: StateStatus.inProgress));
    final resultSms = await checkSmsUseCase.callUseCase(event.params);
    await resultSms.fold(
      (fail) async => emit(state.copyWith(smsStatus: StateStatus.failure, errorMessage: fail.message)),
      (data) async {
        _timer?.cancel();
        emit(state.copyWith(smsStatus: StateStatus.success));
      },
    );
  }

  Future<void> _resend(Emitter<ResetSmsState> emit, String phone) async {
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
