abstract class NewPinEvent {}

class InitEvent extends NewPinEvent {}

class SavePinEvent extends NewPinEvent {
  final String pinCode;

  SavePinEvent({required this.pinCode});
}

class UpdateFieldEvent extends NewPinEvent {
  final String pinCode;

  UpdateFieldEvent({required this.pinCode});
}
