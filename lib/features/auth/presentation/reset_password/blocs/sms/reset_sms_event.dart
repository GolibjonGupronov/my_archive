import 'package:my_archive/features/auth/domain/use_cases/check_sms_use_case.dart';

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
