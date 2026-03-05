import 'package:flutter/material.dart';
import 'package:my_archive/core/app_router/route_exports.dart';
import 'package:my_archive/features/auth/domain/use_cases/registration_use_case.dart';

final GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  initialLocation: SplashPage.tag,
  debugLogDiagnostics: true,
  navigatorKey: globalNavigatorKey,
  routes: <RouteBase>[
    GoRoute(
      path: SplashPage.tag,
      pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
        context: context,
        state: state,
        child: SplashPage(),
      ),
    ),
    GoRoute(
      path: UpdatePage.tag,
      pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
        context: context,
        state: state,
        child: UpdatePage(),
      ),
    ),
    GoRoute(
      path: MainPage.tag,
      pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
        context: context,
        state: state,
        child: MainPage(),
      ),
    ),
    GoRoute(
      path: RegistrationPage.tag,
      pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
        context: context,
        state: state,
        child: RegistrationPage(),
      ),
    ),
    GoRoute(
      path: ImageZoomPage.tag,
      pageBuilder: (context, state) {
        final items = List<String>.from(state.extra as List);
        if (items.isEmpty) {
          return buildPageWithFadeTransition<void>(
            context: context,
            state: state,
            child: NoImagePage(),
          );
        }
        return buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: ImageZoomPage(items: items),
        );
      },
    ),
    GoRoute(
      path: SettingsPage.tag,
      pageBuilder: (context, state) => buildPageWithSlideRightTransition<void>(
        context: context,
        state: state,
        child: SettingsPage(),
      ),
    ),
    GoRoute(
      path: SetupPage.tag,
      pageBuilder: (context, state) => buildPageWithSlideRightTransition<void>(
        context: context,
        state: state,
        child: SetupPage(),
      ),
    ),
    GoRoute(
      path: LoginPage.tag,
      pageBuilder: (context, state) => buildPageWithSlideRightTransition<void>(
        context: context,
        state: state,
        child: LoginPage(),
      ),
    ),
    GoRoute(
      path: ResetPhonePage.tag,
      pageBuilder: (context, state) => buildPageWithSlideRightTransition<void>(
        context: context,
        state: state,
        child: ResetPhonePage(),
      ),
    ),
    GoRoute(
      path: ResetSmsPage.tag,
      pageBuilder: (context, state) => buildPageWithSlideRightTransition<void>(
        context: context,
        state: state,
        child: ResetSmsPage(phoneNumber: state.extra as String),
      ),
    ),
    GoRoute(
      path: RegSmsPage.tag,
      pageBuilder: (context, state) => buildPageWithSlideRightTransition<void>(
        context: context,
        state: state,
        child: RegSmsPage(registrationParams: state.extra as RegistrationParams),
      ),
    ),
    GoRoute(
      path: NewPasswordPage.tag,
      pageBuilder: (context, state) => buildPageWithSlideRightTransition<void>(
        context: context,
        state: state,
        child: NewPasswordPage(),
      ),
    ),
    GoRoute(
      path: OldPasswordPage.tag,
      pageBuilder: (context, state) => buildPageWithSlideRightTransition<void>(
        context: context,
        state: state,
        child: OldPasswordPage(),
      ),
    ),
    GoRoute(
      path: EditProfilePage.tag,
      pageBuilder: (context, state) => buildPageWithSlideRightTransition<void>(
        context: context,
        state: state,
        child: EditProfilePage(),
      ),
    ),
  ],
);

CustomTransitionPage buildPageWithScaleTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) => ScaleTransition(scale: animation, child: child),
  );
}

CustomTransitionPage buildPageWithFadeTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}

CustomTransitionPage<T> buildPageWithSlideUpTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final Offset begin = Offset(0.0, 1.0);
      final Offset end = Offset.zero;
      final Tween<Offset> offsetTween = Tween(begin: begin, end: end);
      final Animation<Offset> offsetAnimation = animation.drive(offsetTween);
      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}

CustomTransitionPage<T> buildPageWithSlideRightTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final Offset begin = Offset(1.0, 0.0);
      final Offset end = Offset.zero;
      final Tween<Offset> offsetTween = Tween(begin: begin, end: end);
      final Animation<Offset> offsetAnimation = animation.drive(offsetTween);
      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}
