import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/device_session/domain/entities/device_session_entity.dart';

class DeviceSessionState {
  final StateStatus sessionStatus;
  final StateStatus terminateStatus;
  final List<DeviceSessionEntity> noActiveDevices;
  final DeviceSessionEntity? activeDevice;
  final bool noDevice;
  final String errorMessage;

  DeviceSessionState({
    this.sessionStatus = StateStatus.initial,
    this.terminateStatus = StateStatus.initial,
    this.noActiveDevices = const [],
    this.activeDevice,
    this.noDevice = true,
    this.errorMessage = "",
  });

  DeviceSessionState copyWith({
    StateStatus? sessionStatus,
    StateStatus? terminateStatus,
    List<DeviceSessionEntity>? noActiveDevices,
    DeviceSessionEntity? activeDevice,
    bool? noDevice,
    String? errorMessage,
  }) =>
      DeviceSessionState(
        sessionStatus: sessionStatus ?? this.sessionStatus,
        terminateStatus: terminateStatus ?? this.terminateStatus,
        noActiveDevices: noActiveDevices ?? this.noActiveDevices,
        activeDevice: activeDevice ?? this.activeDevice,
        noDevice: noDevice ?? this.noDevice,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
