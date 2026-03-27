abstract class ProfileEvent {}

class InitEvent extends ProfileEvent {}

class ChangeImageEvent extends ProfileEvent {
  final String path;

  ChangeImageEvent({required this.path});
}

class IsGrantedEvent extends ProfileEvent {}

class CheckBiometricEvent extends ProfileEvent {}

class EnableNotificationEvent extends ProfileEvent {
  final bool value;

  EnableNotificationEvent({required this.value});
}

class ToggleBiometricEvent extends ProfileEvent {
  final bool value;

  ToggleBiometricEvent({required this.value});
}
