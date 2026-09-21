abstract class ProfileEvent {}

class InitEvent extends ProfileEvent {}

class ChangeImageEvent extends ProfileEvent {
  final String path;

  ChangeImageEvent({required this.path});
}

class IsGrantedEvent extends ProfileEvent {}

class EnableNotificationEvent extends ProfileEvent {
  final bool value;

  EnableNotificationEvent({required this.value});
}
