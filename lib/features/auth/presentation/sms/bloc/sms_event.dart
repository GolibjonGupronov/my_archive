import 'package:my_archive/features/auth/domain/use_cases/check_sms_use_case.dart';

abstract class SmsEvent {}

class InitEvent extends SmsEvent {}

class CheckSmsEvent extends SmsEvent {
  final CheckSmsParams params;

  CheckSmsEvent({required this.params});
}

class GetUserInfoEvent extends SmsEvent {}
