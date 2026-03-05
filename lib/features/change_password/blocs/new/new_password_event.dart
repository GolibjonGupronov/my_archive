abstract class NewPasswordEvent {}

class InitEvent extends NewPasswordEvent {}

class SubmitEvent extends NewPasswordEvent {
  final String password;

  SubmitEvent({required this.password});
}

class UpdateFieldEvent extends NewPasswordEvent {
  final String? newPassword;
  final String? againNewPassword;

  UpdateFieldEvent({this.newPassword, this.againNewPassword});
}
