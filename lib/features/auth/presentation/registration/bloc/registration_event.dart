import 'package:my_archive/core/enums/gender.dart';

abstract class RegistrationEvent {}

class InitEvent extends RegistrationEvent {}

class StartTimerEvent extends RegistrationEvent {}

class ResendPhoneEvent extends RegistrationEvent {
  final String phone;

  ResendPhoneEvent({required this.phone});
}

class SecondEvent extends RegistrationEvent {
  final int second;

  SecondEvent({required this.second});
}

class UpdateFieldEvent extends RegistrationEvent {
  final String? code;
  final String? firstName;
  final String? secondName;
  final Gender? gender;
  final DateTime? birthDay;

  UpdateFieldEvent({this.code, this.firstName, this.secondName, this.gender, this.birthDay});
}
