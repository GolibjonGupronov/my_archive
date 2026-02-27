import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_archive/core/constants/constants.dart';
import 'package:my_archive/core/enums/state_status.dart';
import 'package:my_archive/core/use_cases/usecase.dart';
import 'package:my_archive/features/auth/domain/use_cases/check_sms_use_case.dart';
import 'package:my_archive/features/auth/domain/use_cases/send_phone_use_case.dart';
import 'package:my_archive/features/auth/domain/use_cases/user_info_use_case.dart';
import 'package:my_archive/features/auth/presentation/sms/bloc/sms_event.dart';
import 'package:my_archive/features/auth/presentation/sms/bloc/sms_state.dart';

class SmsBloc extends Bloc<SmsEvent, SmsState> {
  final CheckSmsUseCase checkSmsUseCase;
  final SendPhoneUseCase sendPhoneUseCase;
  final UserInfoUseCase userInfoUseCase;
  Timer? _timer;
  int _seconds = Constants.smsResendPhoneSecond;

  SmsBloc({required this.checkSmsUseCase, required this.userInfoUseCase, required this.sendPhoneUseCase}) : super(SmsState()) {
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

  Future<void> _submit(SubmitEvent event, Emitter<SmsState> emit) async {
    emit(state.copyWith(smsStatus: StateStatus.inProgress));
    final either = await checkSmsUseCase.call(event.params);
    await either.fold(
      (fail) async => emit(state.copyWith(smsStatus: StateStatus.failure, errorMessage: fail.message)),
      (data) async {
        final either = await userInfoUseCase.call(NoParams());
        either.fold(
          (fail) => emit(state.copyWith(smsStatus: StateStatus.failure, errorMessage: fail.message)),
          (data) => emit(state.copyWith(smsStatus: StateStatus.success, userInfo: data)),
        );
      },
    );
  }

  Future<void> _resend(Emitter<SmsState> emit, String phone) async {
    emit(state.copyWith(resendPhoneStatus: StateStatus.inProgress));
    final result = await sendPhoneUseCase.call(phone);
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
