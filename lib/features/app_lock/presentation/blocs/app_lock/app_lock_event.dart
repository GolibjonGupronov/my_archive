abstract class AppLockEvent {}

class InitEvent extends AppLockEvent {}

class CheckPinEvent extends AppLockEvent {
  final String pinCode;

  CheckPinEvent({required this.pinCode});
}

class UpdateFieldEvent extends AppLockEvent {
  final String pinCode;

  UpdateFieldEvent({required this.pinCode});
}
