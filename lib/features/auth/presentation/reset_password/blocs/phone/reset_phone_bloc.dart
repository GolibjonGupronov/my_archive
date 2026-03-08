import 'package:bloc/bloc.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/auth/domain/use_cases/send_phone_use_case.dart';

import 'package:my_archive/features/auth/presentation/reset_password/blocs/phone/reset_phone_event.dart';
import 'package:my_archive/features/auth/presentation/reset_password/blocs/phone/reset_phone_state.dart';

class ResetPhoneBloc extends Bloc<ResetPhoneEvent, ResetPhoneState> {
  final SendPhoneUseCase sendPhoneUseCase;

  ResetPhoneBloc({required this.sendPhoneUseCase}) : super(ResetPhoneState()) {
    on<InitEvent>((event, emit) {});

    on<UpdateFieldEvent>((event, emit) {
      final phone = event.phone ?? state.phone;
      final phoneDigits = phone.replaceAll(RegExp(r'\D'), '');
      final isActive = phoneDigits.length == 9;
      emit(state.copyWith(phone: phone, isActive: isActive));
    });

    on<SubmitEvent>((event, emit) async {
      await _submit(event, emit);
    });
  }

  Future<void> _submit(SubmitEvent event, Emitter<ResetPhoneState> emit) async {
    emit(state.copyWith(phoneStatus: StateStatus.inProgress));
    final result = await sendPhoneUseCase.callUseCase(event.phone);
    result.fold((fail) {
      emit(state.copyWith(phoneStatus: StateStatus.failure, errorMessage: fail.message));
    }, (data) {
      emit(state.copyWith(phoneStatus: StateStatus.success));
    });
  }
}
