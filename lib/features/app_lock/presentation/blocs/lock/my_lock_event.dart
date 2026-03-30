abstract class MyLockEvent {}

class InitEvent extends MyLockEvent {}

class CheckBiometricEvent extends MyLockEvent {}

class ToggleBiometricEvent extends MyLockEvent {
  final bool value;

  ToggleBiometricEvent({required this.value});
}

class RemovePinEvent extends MyLockEvent {}
