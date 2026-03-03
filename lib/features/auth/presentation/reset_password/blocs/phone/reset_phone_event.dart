abstract class ResetPhoneEvent {}

class InitEvent extends ResetPhoneEvent {}

class UpdateFieldEvent extends ResetPhoneEvent {
  final String? phone;

  UpdateFieldEvent({this.phone});
}

class SubmitEvent extends ResetPhoneEvent {
  final String phone;

  SubmitEvent({required this.phone});
}
