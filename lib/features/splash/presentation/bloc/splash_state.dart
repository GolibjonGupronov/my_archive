import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/auth/domain/entities/app_config_entity.dart';

class SplashState {
  final StateStatus splashStatus;
  final NextPage nextPage;
  final String errorMessage;
  final bool isFirstLaunch;
  final AppConfigEntity? appConfig;

  SplashState({
    this.splashStatus = StateStatus.initial,
    this.nextPage = NextPage.main,
    this.errorMessage = '',
    this.isFirstLaunch = false,
    this.appConfig,
  });

  SplashState copyWith({
    StateStatus? splashStatus,
    NextPage? nextPage,
    String? errorMessage,
    bool? isFirstLaunch,
    AppConfigEntity? appConfig,
  }) =>
      SplashState(
        splashStatus: splashStatus ?? this.splashStatus,
        nextPage: nextPage ?? this.nextPage,
        errorMessage: errorMessage ?? this.errorMessage,
        isFirstLaunch: isFirstLaunch ?? this.isFirstLaunch,
        appConfig: appConfig ?? this.appConfig,
      );
}
