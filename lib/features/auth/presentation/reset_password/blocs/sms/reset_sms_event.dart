import 'package:my_archive/core/params/check_sms_params.dart';

abstract class ResetSmsEvent {}

class InitEvent extends ResetSmsEvent {}

class UpdateFieldEvent extends ResetSmsEvent {
  final String? code;

  UpdateFieldEvent({this.code});
}

class SubmitEvent extends ResetSmsEvent {
  final CheckSmsParams params;

  SubmitEvent({required this.params});
}

class StartTimerEvent extends ResetSmsEvent {}

class ResendPhoneEvent extends ResetSmsEvent {
  final String phone;

  ResendPhoneEvent({required this.phone});
}

class SecondEvent extends ResetSmsEvent {
  final int second;

  SecondEvent({required this.second});
}
