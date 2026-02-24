import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_archive/core/enums/state_status.dart';
import 'package:my_archive/core/use_cases/usecase.dart';
import 'package:my_archive/features/auth/domain/use_cases/check_sms_use_case.dart';
import 'package:my_archive/features/auth/domain/use_cases/user_info_use_case.dart';
import 'package:my_archive/features/auth/presentation/sms/bloc/sms_event.dart';
import 'package:my_archive/features/auth/presentation/sms/bloc/sms_state.dart';

class SmsBloc extends Bloc<SmsEvent, SmsState> {
  final CheckSmsUseCase checkSmsUseCase;
  final UserInfoUseCase userInfoUseCase;

  SmsBloc({required this.checkSmsUseCase, required this.userInfoUseCase}) : super(SmsState()) {
    on<InitEvent>((event, emit) async {});

    on<CheckSmsEvent>((event, emit) async {
      await _checkSms(event, emit);
    });
    on<GetUserInfoEvent>((event, emit) async {
      await _getUser(emit);
    });
  }

  Future<void> _checkSms(CheckSmsEvent event, Emitter<SmsState> emit) async {
    emit(state.copyWith(smsStatus: StateStatus.inProgress));
    final either = await checkSmsUseCase.call(event.params);
    either.fold(
      (fail) => emit(state.copyWith(smsStatus: StateStatus.failure, errorMessage: fail.message)),
      (data) => add(GetUserInfoEvent()),
    );
  }

  Future<void> _getUser(Emitter<SmsState> emit) async {
    final either = await userInfoUseCase.call(NoParams());
    either.fold(
      (fail) => emit(state.copyWith(smsStatus: StateStatus.failure, errorMessage: fail.message)),
      (data) => emit(state.copyWith(smsStatus: StateStatus.success, userInfo: data)),
    );
  }
}
