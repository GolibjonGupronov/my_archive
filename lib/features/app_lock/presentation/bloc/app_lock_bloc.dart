import 'package:bloc/bloc.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/core/local_storage/secure_storage.dart';
import 'package:my_archive/core/services/local_auth_service.dart';
import 'package:my_archive/features/app_lock/presentation/bloc/app_lock_event.dart';
import 'package:my_archive/features/app_lock/presentation/bloc/app_lock_state.dart';

class AppLockBloc extends Bloc<AppLockEvent, AppLockState> {
  final SecureStorage secureStorage;
  final PrefManager prefManager;

  AppLockBloc({required this.secureStorage, required this.prefManager}) : super(AppLockState()) {
    on<InitEvent>((event, emit) async {
      emit(state.copyWith(isNewPinCode: (!await secureStorage.hasPin())));
    });

    on<SavePinEvent>((event, emit) async {
      emit(state.copyWith(appLockStatus: StateStatus.inProgress));
      if (prefManager.isBiometric == null) await LocalAuthService.tryBiometric();
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
}
