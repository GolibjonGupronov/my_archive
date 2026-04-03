import 'package:flutter/material.dart';
import 'package:my_archive/core/app_router/args.dart';
import 'package:my_archive/core/app_router/route_exports.dart';
import 'package:my_archive/features/auth/domain/entities/app_config_entity.dart';
import 'package:my_archive/features/auth/domain/use_cases/registration_use_case.dart';
import 'package:my_archive/features/profile/presentation/bloc/profile_bloc.dart';

enum AppTransitionType { fade, slideRight, slideUp, scale }

final GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  initialLocation: SplashPage.tag,
  debugLogDiagnostics: true,
  navigatorKey: globalNavigatorKey,
  routes: <RouteBase>[
    GoRoute(
      path: SplashPage.tag,
      pageBuilder: (context, state) => buildPage<void>(
        state: state,
        type: AppTransitionType.fade,
        child: SplashPage(),
      ),
    ),
    GoRoute(
      path: UpdatePage.tag,
      pageBuilder: (context, state) => buildPage<void>(
        state: state,
        type: AppTransitionType.fade,
        child: UpdatePage(appConfigEntity: state.extra as AppConfigEntity),
      ),
    ),
    GoRoute(
      path: MainPage.tag,
      pageBuilder: (context, state) => buildPage<void>(
        state: state,
        type: AppTransitionType.fade,
        child: MainPage(),
      ),
    ),
    GoRoute(
      path: RegistrationPage.tag,
      pageBuilder: (context, state) => buildPage<void>(
        state: state,
        type: AppTransitionType.fade,
        child: RegistrationPage(),
      ),
    ),
    GoRoute(
      path: ImageZoomPage.tag,
      pageBuilder: (context, state) {
        final items = List<String>.from(state.extra as List);
        if (items.isEmpty) {
          return buildPage<void>(
            state: state,
            type: AppTransitionType.fade,
            child: NoImagePage(),
          );
        }
        return buildPage<void>(
          state: state,
          type: AppTransitionType.fade,
          child: ImageZoomPage(items: items),
        );
      },
    ),
    GoRoute(
      path: SettingsPage.tag,
      pageBuilder: (context, state) => buildPage<void>(
        state: state,
        child: SettingsPage(bloc: state.extra as ProfileBloc),
      ),
    ),
    GoRoute(
      path: SecurityPage.tag,
      pageBuilder: (context, state) => buildPage<void>(
        state: state,
        child: SecurityPage(bloc: state.extra as ProfileBloc),
      ),
    ),
    GoRoute(
      path: LoginPage.tag,
      pageBuilder: (context, state) => buildPage<void>(
        state: state,
        child: LoginPage(),
      ),
    ),
    GoRoute(
      path: ResetPhonePage.tag,
      pageBuilder: (context, state) => buildPage<void>(
        state: state,
        child: ResetPhonePage(),
      ),
    ),
    GoRoute(
      path: ResetSmsPage.tag,
      pageBuilder: (context, state) => buildPage<void>(
        state: state,
        child: ResetSmsPage(phoneNumber: state.extra as String),
      ),
    ),
    GoRoute(
      path: RegSmsPage.tag,
      pageBuilder: (context, state) => buildPage<void>(
        state: state,
        child: RegSmsPage(registrationParams: state.extra as RegistrationParams),
      ),
    ),
    GoRoute(
      path: NewPasswordPage.tag,
      pageBuilder: (context, state) => buildPage<void>(
        state: state,
        child: NewPasswordPage(),
      ),
    ),
    GoRoute(
      path: OldPasswordPage.tag,
      pageBuilder: (context, state) => buildPage<void>(
        state: state,
        child: OldPasswordPage(),
      ),
    ),
    GoRoute(
      path: EditProfilePage.tag,
      pageBuilder: (context, state) => buildPage<void>(
        state: state,
        child: EditProfilePage(),
      ),
    ),
    GoRoute(
      path: StoryPage.tag,
      pageBuilder: (context, state) {
        final args = state.extra as StoryPageArgs;
        return buildPage<void>(
          state: state,
          child: StoryPage(storyList: args.storyList, activeIndex: args.activeIndex, itemCheck: args.itemCheck),
        );
      },
    ),
    GoRoute(
      path: DeviceSessionPage.tag,
      pageBuilder: (context, state) => buildPage<void>(
        state: state,
        child: DeviceSessionPage(),
      ),
    ),
    GoRoute(
      path: AppLockPage.tag,
      pageBuilder: (context, state) => buildPage<void>(
        state: state,
        type: AppTransitionType.scale,
        child: AppLockPage(),
      ),
    ),
    GoRoute(
      path: CurrentPinPage.tag,
      pageBuilder: (context, state) => buildPage<void>(
        state: state,
        child: CurrentPinPage(),
      ),
    ),
    GoRoute(
      path: MyLockPage.tag,
      pageBuilder: (context, state) => buildPage<void>(
        state: state,
        child: MyLockPage(),
      ),
    ),
    GoRoute(
      path: NewPinPage.tag,
      pageBuilder: (context, state) => buildPage<void>(
        state: state,
        child: NewPinPage(),
      ),
    ),
    GoRoute(
      path: HelpPage.tag,
      pageBuilder: (context, state) => buildPage<void>(
        state: state,
        child: HelpPage(),
      ),
    ),
    GoRoute(
      path: FaqPage.tag,
      pageBuilder: (context, state) => buildPage<void>(
        state: state,
        child: FaqPage(),
      ),
    ),
  ],
);

CustomTransitionPage<T> buildPage<T>({
  required GoRouterState state,
  required Widget child,
  AppTransitionType type = AppTransitionType.slideRight,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      switch (type) {
        case AppTransitionType.fade:
          return FadeTransition(opacity: animation, child: child);

        case AppTransitionType.slideRight:
          return SlideTransition(
            position: animation.drive(Tween(begin: const Offset(1, 0), end: Offset.zero)),
            child: child,
          );

        case AppTransitionType.slideUp:
          return SlideTransition(
            position: animation.drive(Tween(begin: const Offset(0, 1), end: Offset.zero)),
            child: child,
          );

        case AppTransitionType.scale:
          return ScaleTransition(scale: animation, child: child);
      }
    },
  );
}
