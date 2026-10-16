import 'package:my_archive/core/params/registration_params.dart';

abstract class RegSmsEvent {}

class InitEvent extends RegSmsEvent {}

class UpdateFieldEvent extends RegSmsEvent {
  final String? code;

  UpdateFieldEvent({this.code});
}

class SubmitEvent extends RegSmsEvent {
  final RegistrationParams params;

  SubmitEvent({required this.params});
}

class StartTimerEvent extends RegSmsEvent {}

class ResendPhoneEvent extends RegSmsEvent {
  final String phone;

  ResendPhoneEvent({required this.phone});
}

class SecondEvent extends RegSmsEvent {
  final int second;

  SecondEvent({required this.second});
}
