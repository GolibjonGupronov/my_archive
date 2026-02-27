

abstract class PhoneEvent {}

class InitEvent extends PhoneEvent {}

class UpdateFieldEvent extends PhoneEvent {
  final String? phone;

  UpdateFieldEvent({this.phone});
}

class SubmitEvent extends PhoneEvent {
  final String phone;

  SubmitEvent({required this.phone});
}
