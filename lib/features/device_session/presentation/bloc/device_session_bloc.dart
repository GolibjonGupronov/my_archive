import 'package:bloc/bloc.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/device_session/domain/use_cases/device_session_use_case.dart';
import 'package:my_archive/features/device_session/presentation/bloc/device_session_event.dart';
import 'package:my_archive/features/device_session/presentation/bloc/device_session_state.dart';

class DeviceSessionBloc extends Bloc<DeviceSessionEvent, DeviceSessionState> {
  final DeviceSessionUseCase deviceSessionUseCase;

  DeviceSessionBloc({required this.deviceSessionUseCase}) : super(DeviceSessionState()) {
    on<InitEvent>((event, emit) {
      add(LoadDataEvent());
    });

    on<LoadDataEvent>((event, emit) async {
      emit(state.copyWith(sessionStatus: StateStatus.inProgress));
      final result = await deviceSessionUseCase.callUseCase(NoParams());
      result.fold((fail) {
        emit(state.copyWith(sessionStatus: StateStatus.failure, errorMessage: fail.message));
      }, (data) {
        emit(state.copyWith(sessionStatus: StateStatus.success, deviceSessions: data));
      });
    });
  }
}
