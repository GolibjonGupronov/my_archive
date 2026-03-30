abstract class CurrentPinEvent {}

class InitEvent extends CurrentPinEvent {}

class CheckCurrentPinEvent extends CurrentPinEvent {
  final String pinCode;

  CheckCurrentPinEvent({required this.pinCode});
}

class UpdateFieldEvent extends CurrentPinEvent {
  final String pinCode;

  UpdateFieldEvent({required this.pinCode});
}
