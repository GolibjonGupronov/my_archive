import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/core/local_storage/remove_storage.dart';
import 'package:my_archive/core/local_storage/secure_storage.dart';

import 'my_lock_event.dart';
import 'my_lock_state.dart';

class MyLockBloc extends Bloc<MyLockEvent, MyLockState> {
  final SecureStorage secureStorage;
  final PrefManager prefManager;

  MyLockBloc({required this.secureStorage, required this.prefManager}) : super(MyLockState()) {
    on<InitEvent>((event, emit) async {
      emit(state.copyWith(hasPin: await secureStorage.hasPin(), autoLockTime: prefManager.getAutoLockTime));
      add(CheckBiometricEvent());
    });

    on<ToggleBiometricEvent>((event, emit) async {
      await prefManager.setBiometric(event.value);
      emit(state.copyWith(isBiometricEnabled: prefManager.isBiometric));
      debugPrint("GGQ => State after ToggleBiometricEvent: ${state.isBiometricEnabled}");
    });

    on<CheckBiometricEvent>((event, emit) async {
      debugPrint("GGQ => CheckBiometricEvent ${prefManager.isBiometric}");
      emit(state.copyWith(isBiometricEnabled: prefManager.isBiometric));
      debugPrint("GGQ => State after CheckBiometricEvent: ${state.isBiometricEnabled}");
    });

    on<RemovePinEvent>((event, emit) async {
      emit(state.copyWith(pinStatus: StateStatus.inProgress));
      await RemoveStorage.removePin();
      emit(state.copyWith(pinStatus: StateStatus.success));
    });

    on<AutoLockTimeEvent>((event, emit) async {
      await prefManager.setAutoLockTime(event.timeType);
      emit(state.copyWith(autoLockTime: event.timeType));
    });
  }
}
