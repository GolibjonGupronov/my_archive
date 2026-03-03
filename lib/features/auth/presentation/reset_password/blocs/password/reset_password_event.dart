abstract class ResetPasswordEvent {}

class InitEvent extends ResetPasswordEvent {}

class UpdateFieldEvent extends ResetPasswordEvent {
  final String? newPassword;
  final String? againNewPassword;

  UpdateFieldEvent({this.newPassword, this.againNewPassword});
}
