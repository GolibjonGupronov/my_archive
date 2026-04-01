import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/device_session/domain/use_cases/device_session_use_case.dart';
import 'package:my_archive/features/device_session/domain/use_cases/terminate_device_use_case.dart';
import 'package:my_archive/features/device_session/presentation/bloc/device_session_event.dart';
import 'package:my_archive/features/device_session/presentation/bloc/device_session_state.dart';

class DeviceSessionBloc extends Bloc<DeviceSessionEvent, DeviceSessionState> {
  final DeviceSessionUseCase deviceSessionUseCase;
  final TerminateDeviceUseCase terminateDeviceUseCase;

  DeviceSessionBloc({required this.deviceSessionUseCase, required this.terminateDeviceUseCase}) : super(DeviceSessionState()) {
    on<InitEvent>((event, emit) {
      add(LoadDataEvent());
    });

    on<LoadDataEvent>((event, emit) async {
      emit(state.copyWith(sessionStatus: StateStatus.inProgress));
      final result = await deviceSessionUseCase.callUseCase(NoParams());
      result.fold((fail) {
        emit(state.copyWith(sessionStatus: StateStatus.failure, errorMessage: fail.message));
      }, (data) {
        final activeDevise = data.firstWhereOrNull((e) => e.isCurrent);
        final noActiveDevices = data.where((e) => !e.isCurrent).toList();
        emit(state.copyWith(
            sessionStatus: StateStatus.success,
            noActiveDevices: noActiveDevices,
            activeDevice: activeDevise,
            noDevice: data.isEmpty));
      });
    });

    on<TerminateAllEvent>((event, emit) async {
      await terminate(emit, -1);
    });

    on<TerminateDeviceEvent>((event, emit) async {
      await terminate(emit, event.id);
    });
  }

  Future<void> terminate(Emitter<DeviceSessionState> emit, int id) async {
    emit(state.copyWith(terminateStatus: StateStatus.inProgress));
    final result = await terminateDeviceUseCase.callUseCase(id);
    result.fold((fail) {
      emit(state.copyWith(terminateStatus: StateStatus.failure, errorMessage: fail.message));
    }, (data) {
      emit(state.copyWith(terminateStatus: StateStatus.success));
    });
  }
}
