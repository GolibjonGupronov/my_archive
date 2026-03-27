import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/core/local_storage/secure_storage.dart';
import 'package:my_archive/features/app_lock/presentation/bloc/app_lock_event.dart';
import 'package:my_archive/features/app_lock/presentation/bloc/app_lock_state.dart';

class AppLockBloc extends Bloc<AppLockEvent, AppLockState> {
  final SecureStorage secureStorage;
  final PrefManager prefManager;
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  AppLockBloc({required this.secureStorage, required this.prefManager}) : super(AppLockState()) {
    on<InitEvent>((event, emit) async {
      emit(state.copyWith(isNewPinCode: (!await secureStorage.hasPin())));
    });
    on<SavePinEvent>((event, emit) async {
      emit(state.copyWith(appLockStatus: StateStatus.inProgress));
      if (!prefManager.isBiometric) await _tryBiometric();
      await secureStorage.savePin(event.pinCode);
      emit(state.copyWith(appLockStatus: StateStatus.success));
    });

    on<CheckOldPinEvent>((event, emit) async {
      emit(state.copyWith(checkOldPinStatus: StateStatus.initial));
      if (await secureStorage.checkPin(event.pinCode)) {
        emit(state.copyWith(isNewPinCode: true, isActive: false));
      } else {
        emit(state.copyWith(checkOldPinStatus: StateStatus.failure, errorMessage: "Noto'g'ri pin kod"));
      }
    });

    on<UpdateFieldEvent>((event, emit) {
      emit(state.copyWith(isActive: event.pinCode.length == Constants.pinCodeLength));
    });
  }

  Future<void> _tryBiometric() async {
    if (await canUseBiometric()) {
      bool ok = await authenticate();
      debugPrint("GGQ => biometric auth result: $ok");
      prefManager.setBiometric(ok);
    }
  }

  Future<bool> canUseBiometric() async {
    return await _localAuthentication.canCheckBiometrics && await _localAuthentication.isDeviceSupported();
  }

  Future<bool> authenticate() async {
    try {
      debugPrint("GGQ => authenticate");
      return await _localAuthentication.authenticate(
        localizedReason: 'Qulfni ochish uchun tasdiqlang',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      debugPrint("GGQ => error $e");
      return false;
    }
  }
}
