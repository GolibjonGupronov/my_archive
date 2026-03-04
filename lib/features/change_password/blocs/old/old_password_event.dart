abstract class OldPasswordEvent {}

class InitEvent extends OldPasswordEvent {}

class UpdateFieldEvent extends OldPasswordEvent {
  final String? password;

  UpdateFieldEvent({this.password});
}

class SubmitEvent extends OldPasswordEvent {
  final String password;

  SubmitEvent({required this.password});
}
