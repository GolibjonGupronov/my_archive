import 'package:my_archive/features/auth/domain/use_cases/login_use_case.dart';

abstract class LoginEvent {}

class InitEvent extends LoginEvent {}

class UpdateFieldEvent extends LoginEvent {
  final String? phone;
  final String? password;

  UpdateFieldEvent({this.phone, this.password});
}

class SubmitEvent extends LoginEvent {
  final LoginParams params;

  SubmitEvent({required this.params});
}
