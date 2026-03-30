import 'package:bloc/bloc.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/core/local_storage/secure_storage.dart';
import 'package:my_archive/core/services/local_auth_service.dart';
import 'package:my_archive/features/app_lock/presentation/bloc/app_lock/app_lock_event.dart';
import 'package:my_archive/features/app_lock/presentation/bloc/app_lock/app_lock_state.dart';

class AppLockBloc extends Bloc<AppLockEvent, AppLockState> {
  final SecureStorage secureStorage;
  final PrefManager prefManager;

  AppLockBloc({required this.secureStorage, required this.prefManager}) : super(AppLockState()) {
    on<InitEvent>((event, emit) async {
      if (prefManager.isBiometric == true) {
        emit(state.copyWith(lockStatus: StateStatus.inProgress));
        if (await LocalAuthService.canUseBiometric()) {
          if (await LocalAuthService.authenticate()) {
            emit(state.copyWith(lockStatus: StateStatus.success));
          }
        }
      }
    });

    on<UpdateFieldEvent>((event, emit) {
      emit(state.copyWith(isActive: event.pinCode.length == Constants.pinCodeLength));
    });

    on<CheckPinEvent>((event, emit) async {
      emit(state.copyWith(lockStatus: StateStatus.inProgress));
      if (await secureStorage.checkPin(event.pinCode)) {
        emit(state.copyWith(lockStatus: StateStatus.success));
      } else {
        emit(state.copyWith(lockStatus: StateStatus.failure, errorMessage: "Noto'g'ri pin kod"));
      }
    });
  }
}
