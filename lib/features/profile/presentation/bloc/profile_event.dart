abstract class ProfileEvent {}

class InitEvent extends ProfileEvent {}

class ChangeImageEvent extends ProfileEvent {
  final String path;

  ChangeImageEvent(this.path);
}
