

abstract class PhoneEvent {}

class InitEvent extends PhoneEvent {}

class UpdateFieldEvent extends PhoneEvent {
  final String? phone;

  UpdateFieldEvent({this.phone});
}

class SendPhoneEvent extends PhoneEvent {
  final String phone;

  SendPhoneEvent({required this.phone});
}
