import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_archive/core/enums/common.dart';
import 'package:my_archive/core/enums/state_status.dart';
import 'package:my_archive/features/auth/domain/use_cases/send_phone_use_case.dart';
import 'package:my_archive/features/auth/presentation/phone/bloc/phone_event.dart';
import 'package:my_archive/features/auth/presentation/phone/bloc/phone_state.dart';

class PhoneBloc extends Bloc<PhoneEvent, PhoneState> {
  final SendPhoneUseCase sendPhoneUseCase;

  PhoneBloc({required this.sendPhoneUseCase}) : super(PhoneState()) {
    on<InitEvent>((event, emit) {});

    on<UpdateFieldEvent>((event, emit) {
      final phone = event.phone ?? state.phone;
      final phoneDigits = phone.replaceAll(RegExp(r'\D'), '');
      final isPhoneValid = phoneDigits.length == 9;
      emit(state.copyWith(phone: phone, isActive: isPhoneValid));
    });

    on<SendPhoneEvent>((event, emit) async {
      await _sendPhone(event, emit);
    });
  }

  Future<void> _sendPhone(SendPhoneEvent event, Emitter<PhoneState> emit) async {
    emit(state.copyWith(phoneStatus: StateStatus.inProgress));
    final result = await sendPhoneUseCase.call(event.phone);
    result.fold((fail) {
      emit(state.copyWith(phoneStatus: StateStatus.failure, errorMessage: fail.message));
    }, (data) {
      emit(state.copyWith(
          phoneStatus: StateStatus.success, authNextPage: data.isRegistered ? AuthNextPage.sms : AuthNextPage.registration));
    });
    emit(state.copyWith(phoneStatus: StateStatus.initial));
  }
}
