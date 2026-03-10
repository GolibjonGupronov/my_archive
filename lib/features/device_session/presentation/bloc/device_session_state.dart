import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/device_session/domain/entities/device_session_entity.dart';

class DeviceSessionState {
  final StateStatus sessionStatus;
  final List<DeviceSessionEntity> deviceSessions;
  final String errorMessage;

  DeviceSessionState({
    this.sessionStatus = StateStatus.initial,
    this.deviceSessions = const [],
    this.errorMessage = "",
  });

  DeviceSessionState copyWith({
    StateStatus? sessionStatus,
    List<DeviceSessionEntity>? deviceSessions,
    String? errorMessage,
  }) =>
      DeviceSessionState(
        sessionStatus: sessionStatus ?? this.sessionStatus,
        deviceSessions: deviceSessions ?? this.deviceSessions,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
