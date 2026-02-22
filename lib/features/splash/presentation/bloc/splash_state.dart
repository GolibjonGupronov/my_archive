import 'package:my_archive/core/enums/common.dart';
import 'package:my_archive/core/enums/state_status.dart';

class SplashState {
  final StateStatus splashStatus;
  final NextPage nextPage;

  SplashState({
    this.splashStatus = StateStatus.initial,
    this.nextPage = NextPage.main,
  });

  SplashState copyWith({
    StateStatus? splashStatus,
    NextPage? nextPage,
  }) => SplashState(
    splashStatus: splashStatus ?? this.splashStatus,
    nextPage: nextPage ?? this.nextPage,
  );
}
