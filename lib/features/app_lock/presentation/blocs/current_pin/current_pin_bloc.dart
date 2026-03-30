import 'package:bloc/bloc.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/core/local_storage/secure_storage.dart';

import 'current_pin_event.dart';
import 'current_pin_state.dart';

class CurrentPinBloc extends Bloc<CurrentPinEvent, CurrentPinState> {
  final SecureStorage secureStorage;

  CurrentPinBloc({required this.secureStorage}) : super(CurrentPinState()) {
    on<InitEvent>((event, emit) {});

    on<CheckCurrentPinEvent>((event, emit) async {
      emit(state.copyWith(checkCurrentPinStatus: StateStatus.initial));
      if (await secureStorage.checkPin(event.pinCode)) {
        emit(state.copyWith(checkCurrentPinStatus: StateStatus.success));
      } else {
        emit(state.copyWith(checkCurrentPinStatus: StateStatus.failure, errorMessage: "Noto'g'ri pin kod"));
      }
    });

    on<UpdateFieldEvent>((event, emit) {
      emit(state.copyWith(isActive: event.pinCode.length == Constants.pinCodeLength));
    });
  }
}
