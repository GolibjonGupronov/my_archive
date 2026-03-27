abstract class AppLockEvent {}

class InitEvent extends AppLockEvent {}

class SavePinEvent extends AppLockEvent {
  final String pinCode;

  SavePinEvent({required this.pinCode});
}

class CheckOldPinEvent extends AppLockEvent {
  final String pinCode;

  CheckOldPinEvent({required this.pinCode});
}

class UpdateFieldEvent extends AppLockEvent {
  final String pinCode;

  UpdateFieldEvent({required this.pinCode});
}
