import 'package:bloc/bloc.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/core/local_storage/remove_storage.dart';
import 'package:my_archive/core/local_storage/secure_storage.dart';
import 'package:my_archive/core/services/local_auth_service.dart';

import 'package:my_archive/features/app_lock/presentation/blocs/lock/my_lock_event.dart';
import 'package:my_archive/features/app_lock/presentation/blocs/lock/my_lock_state.dart';

class MyLockBloc extends Bloc<MyLockEvent, MyLockState> {
  final SecureStorage secureStorage;
  final PrefManager prefManager;

  MyLockBloc({required this.secureStorage, required this.prefManager}) : super(MyLockState()) {
    on<InitEvent>((event, emit) async {
      emit(state.copyWith(hasPin: await secureStorage.hasPin(), autoLockTime: prefManager.getAutoLockTime));
      add(CheckBiometricEvent());
    });

    on<ToggleBiometricEvent>((event, emit) async {
      if (prefManager.isBiometric == false) {
        final bool auth = await LocalAuthService.tryBiometric();
        await prefManager.setBiometric(auth);
      } else {
        await prefManager.setBiometric(event.value);
      }
      emit(state.copyWith(isBiometricEnabled: prefManager.isBiometric));
    });

    on<CheckBiometricEvent>((event, emit) async {
      emit(state.copyWith(isBiometricEnabled: prefManager.isBiometric));
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
