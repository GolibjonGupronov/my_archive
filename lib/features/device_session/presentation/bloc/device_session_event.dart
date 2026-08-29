

abstract class DeviceSessionEvent {}

class InitEvent extends DeviceSessionEvent {}

class LoadDataEvent extends DeviceSessionEvent {}

class TerminateAllEvent extends DeviceSessionEvent {}

class TerminateDeviceEvent extends DeviceSessionEvent {
  final String id;

  TerminateDeviceEvent({required this.id});
}
