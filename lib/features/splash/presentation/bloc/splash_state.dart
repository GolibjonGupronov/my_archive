import 'package:my_archive/core/core_exports.dart';

class SplashState {
  final StateStatus splashStatus;
  final NextPage nextPage;
  final String errorMessage;

  SplashState({
    this.splashStatus = StateStatus.initial,
    this.nextPage = NextPage.main,
    this.errorMessage = '',
  });

  SplashState copyWith({
    StateStatus? splashStatus,
    NextPage? nextPage,
    String? errorMessage,
  }) =>
      SplashState(
        splashStatus: splashStatus ?? this.splashStatus,
        nextPage: nextPage ?? this.nextPage,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
