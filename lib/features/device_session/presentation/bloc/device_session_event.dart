import 'package:my_archive/features/device_session/domain/entities/device_session_entity.dart';

abstract class DeviceSessionEvent {}

class InitEvent extends DeviceSessionEvent {}

class LoadDataEvent extends DeviceSessionEvent {}

class TerminateAllEvent extends DeviceSessionEvent {}

class TerminateDeviceEvent extends DeviceSessionEvent {
  final int id;

  TerminateDeviceEvent({required this.id});
}
