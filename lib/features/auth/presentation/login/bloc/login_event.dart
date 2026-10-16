import 'package:my_archive/core/params/login_params.dart';

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
