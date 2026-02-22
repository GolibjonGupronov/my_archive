import 'package:my_archive/features/auth/domain/use_cases/send_phone_use_case.dart';

abstract class PhoneEvent {}

class InitEvent extends PhoneEvent {}

class SendPhoneEvent extends PhoneEvent {
  final SendPhoneParams params;

  SendPhoneEvent({required this.params});
}
