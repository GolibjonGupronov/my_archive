import 'package:my_archive/features/app_lock/presentation/widgets/auto_lock_widget.dart';

abstract class MyLockEvent {}

class InitEvent extends MyLockEvent {}

class CheckBiometricEvent extends MyLockEvent {}

class ToggleBiometricEvent extends MyLockEvent {
  final bool value;

  ToggleBiometricEvent({required this.value});
}

class RemovePinEvent extends MyLockEvent {}

class AutoLockTimeEvent extends MyLockEvent {
  final AutoLockTimeType timeType;

  AutoLockTimeEvent({required this.timeType});
}
