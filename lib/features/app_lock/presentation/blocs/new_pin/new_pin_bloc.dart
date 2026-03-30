import 'package:bloc/bloc.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/core/local_storage/secure_storage.dart';
import 'package:my_archive/core/services/local_auth_service.dart';

import 'new_pin_event.dart';
import 'new_pin_state.dart';

class NewPinBloc extends Bloc<NewPinEvent, NewPinState> {
  final SecureStorage secureStorage;
  final PrefManager prefManager;
  NewPinBloc({required this.secureStorage, required this.prefManager}) : super(NewPinState()) {
    on<InitEvent>((event, emit){});

    on<SavePinEvent>((event, emit) async {
      emit(state.copyWith(appLockStatus: StateStatus.inProgress));
      if (prefManager.isBiometric == null) await LocalAuthService.tryBiometric();
      await secureStorage.savePin(event.pinCode);
      emit(state.copyWith(appLockStatus: StateStatus.success));
    });

    on<UpdateFieldEvent>((event, emit) {
      emit(state.copyWith(isActive: event.pinCode.length == Constants.pinCodeLength));
    });
  }
}
