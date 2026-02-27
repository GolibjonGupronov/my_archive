import 'package:my_archive/features/auth/domain/use_cases/check_sms_use_case.dart';

abstract class SmsEvent {}

class InitEvent extends SmsEvent {}

class UpdateFieldEvent extends SmsEvent {
  final String? code;

  UpdateFieldEvent({this.code});
}

class SubmitEvent extends SmsEvent {
  final CheckSmsParams params;

  SubmitEvent({required this.params});
}

class StartTimerEvent extends SmsEvent {}

class ResendPhoneEvent extends SmsEvent {
  final String phone;

  ResendPhoneEvent({required this.phone});
}

class SecondEvent extends SmsEvent {
  final int second;

  SecondEvent({required this.second});
}
