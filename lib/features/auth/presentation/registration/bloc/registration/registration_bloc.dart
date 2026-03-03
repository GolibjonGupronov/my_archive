import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/auth/domain/use_cases/send_phone_use_case.dart';
import 'package:my_archive/features/auth/domain/use_cases/user_info_use_case.dart';
import 'package:my_archive/features/auth/presentation/registration/bloc/registration/registration_event.dart';
import 'package:my_archive/features/auth/presentation/registration/bloc/registration/registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final SendPhoneUseCase sendPhoneUseCase;
  final UserInfoUseCase userInfoUseCase;

  RegistrationBloc({required this.sendPhoneUseCase, required this.userInfoUseCase}) : super(RegistrationState()) {
    on<InitEvent>((event, emit) {});

    on<SubmitEvent>((event, emit) async {
      await _submit(event, emit);
    });

    on<UpdateFieldEvent>((event, emit) async {
      final firstName = event.firstName ?? state.firstName;
      final secondName = event.secondName ?? state.secondName;
      final birthDay = event.birthDay ?? state.birthDay;
      final gender = event.gender ?? state.gender;

      final phone = event.phone ?? state.phone;
      final phoneDigits = phone.replaceAll(RegExp(r'\D'), '');
      final isActive = birthDay != null && firstName.trim().isNotEmpty && secondName.trim().isNotEmpty && phoneDigits.length == 9;

      emit(state.copyWith(
          phone: phone, firstName: firstName, secondName: secondName, birthDay: birthDay, gender: gender, isActive: isActive));
    });
  }

  Future<void> _submit(SubmitEvent event, Emitter<RegistrationState> emit) async {
    emit(state.copyWith(regStatus: StateStatus.inProgress));
    final result = await sendPhoneUseCase.callUseCase(event.params.phone);
    result.fold((fail) {
      emit(state.copyWith(regStatus: StateStatus.failure, errorMessage: fail.message));
    }, (data) {
      emit(state.copyWith(regStatus: StateStatus.success, params: event.params));
    });
  }
}
