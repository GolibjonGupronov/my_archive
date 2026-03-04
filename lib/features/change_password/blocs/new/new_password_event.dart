abstract class NewPasswordEvent {}

class InitEvent extends NewPasswordEvent {}

class UpdateFieldEvent extends NewPasswordEvent {
  final String? newPassword;
  final String? againNewPassword;

  UpdateFieldEvent({this.newPassword, this.againNewPassword});
}
