import 'package:flutter/material.dart';
import 'package:my_archive/core/app_router/args.dart';
import 'package:my_archive/core/enums/common.dart';
import 'package:my_archive/core/exports/route_exports.dart';
import 'package:my_archive/features/auth/domain/entities/app_config_entity.dart';
import 'package:my_archive/features/auth/domain/use_cases/registration_use_case.dart';

enum _AppTransitionType { fade, slideRight, slideUp, scale }

final GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

final GoRouter router = GoRouter(
  initialLocation: SplashPage.path,
  debugLogDiagnostics: true,
  navigatorKey: globalNavigatorKey,
  observers: [routeObserver],
  routes: <RouteBase>[
    GoRoute(
      path: SplashPage.path,
      pageBuilder: (context, state) => _buildPage<void>(
        state: state,
        type: _AppTransitionType.fade,
        child: const SplashPage(),
      ),
    ),
    GoRoute(
      path: UpdatePage.path,
      pageBuilder: (context, state) => _buildPage<void>(
        state: state,
        type: _AppTransitionType.fade,
        child: UpdatePage(appConfigEntity: state.extra as AppConfigEntity),
      ),
    ),
    GoRoute(
      path: MainPage.path,
      pageBuilder: (context, state) => _buildPage<void>(
        state: state,
        type: _AppTransitionType.fade,
        child: const MainPage(),
      ),
    ),
    GoRoute(
      path: RegistrationPage.path,
      pageBuilder: (context, state) => _buildPage<void>(
        state: state,
        type: _AppTransitionType.fade,
        child: const RegistrationPage(),
      ),
    ),
    GoRoute(
      path: ImageZoomPage.path,
      pageBuilder: (context, state) {
        final extra = state.extra;
        final items = extra is List ? extra.whereType<String>().toList() : <String>[];

        if (items.isEmpty) {
          return _buildPage<void>(
            state: state,
            type: _AppTransitionType.fade,
            child: const NoImagePage(),
          );
        }
        return _buildPage<void>(
          state: state,
          type: _AppTransitionType.fade,
          child: ImageZoomPage(items: items),
        );
      },
    ),
    GoRoute(
      path: SettingsPage.path,
      pageBuilder: (context, state) => _buildPage<void>(
        state: state,
        child: const SettingsPage(),
      ),
    ),
    GoRoute(
      path: SecurityPage.path,
      pageBuilder: (context, state) => _buildPage<void>(
        state: state,
        child: const SecurityPage(),
      ),
    ),
    GoRoute(
      path: LoginPage.path,
      pageBuilder: (context, state) => _buildPage<void>(
        state: state,
        child: const LoginPage(),
      ),
    ),
    GoRoute(
      path: ResetPhonePage.path,
      pageBuilder: (context, state) => _buildPage<void>(
        state: state,
        child: const ResetPhonePage(),
      ),
    ),
    GoRoute(
      path: ResetSmsPage.path,
      pageBuilder: (context, state) => _buildPage<void>(
        state: state,
        child: ResetSmsPage(phoneNumber: state.extra as String),
      ),
    ),
    GoRoute(
      path: RegSmsPage.path,
      pageBuilder: (context, state) => _buildPage<void>(
        state: state,
        child: RegSmsPage(registrationParams: state.extra as RegistrationParams),
      ),
    ),
    GoRoute(
      path: NewPasswordPage.path,
      pageBuilder: (context, state) => _buildPage<void>(
        state: state,
        child: const NewPasswordPage(),
      ),
    ),
    GoRoute(
      path: OldPasswordPage.path,
      pageBuilder: (context, state) => _buildPage<void>(
        state: state,
        child: const OldPasswordPage(),
      ),
    ),
    GoRoute(
      path: EditProfilePage.path,
      pageBuilder: (context, state) => _buildPage<void>(
        state: state,
        child: const EditProfilePage(),
      ),
    ),
    GoRoute(
      path: StoryPage.path,
      pageBuilder: (context, state) {
        final args = state.extra as StoryPageArgs;
        return _buildPage<void>(
          state: state,
          child: StoryPage(storyList: args.storyList, activeIndex: args.activeIndex, itemCheck: args.itemCheck),
        );
      },
    ),
    GoRoute(
      path: DeviceSessionPage.path,
      pageBuilder: (context, state) => _buildPage<void>(
        state: state,
        child: const DeviceSessionPage(),
      ),
    ),
    GoRoute(
      path: AppLockPage.path,
      pageBuilder: (context, state) => _buildPage<void>(
        state: state,
        type: _AppTransitionType.scale,
        child: const AppLockPage(),
      ),
    ),
    GoRoute(
      path: CurrentPinPage.path,
      pageBuilder: (context, state) => _buildPage<void>(
        state: state,
        child: const CurrentPinPage(),
      ),
    ),
    GoRoute(
      path: MyLockPage.path,
      pageBuilder: (context, state) => _buildPage<void>(
        state: state,
        child: const MyLockPage(),
      ),
    ),
    GoRoute(
      path: NewPinPage.path,
      pageBuilder: (context, state) => _buildPage<void>(
        state: state,
        child: const NewPinPage(),
      ),
    ),
    GoRoute(
      path: HelpPage.path,
      pageBuilder: (context, state) => _buildPage<void>(
        state: state,
        child: const HelpPage(),
      ),
    ),
    GoRoute(
      path: FaqPage.path,
      pageBuilder: (context, state) => _buildPage<void>(
        state: state,
        child: const FaqPage(),
      ),
    ),
    GoRoute(
      path: MemoryPage.path,
      pageBuilder: (context, state) => _buildPage<void>(
        state: state,
        child: const MemoryPage(),
      ),
    ),
  ],
);

CustomTransitionPage<T> _buildPage<T>({
  required GoRouterState state,
  required Widget child,
  _AppTransitionType type = _AppTransitionType.slideRight,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      switch (type) {
        case _AppTransitionType.fade:
          return FadeTransition(opacity: animation, child: child);

        case _AppTransitionType.slideRight:
          return SlideTransition(
            position: animation.drive(Tween(begin: const Offset(1, 0), end: Offset.zero)),
            child: child,
          );

        case _AppTransitionType.slideUp:
          return SlideTransition(
            position: animation.drive(Tween(begin: const Offset(0, 1), end: Offset.zero)),
            child: child,
          );

        case _AppTransitionType.scale:
          return ScaleTransition(scale: animation, child: child);
      }
    },
  );
}

extension NextPageRoute on NextPage {
  String get page => switch (this) {
        NextPage.auth => LoginPage.path,
        NextPage.main => MainPage.path,
        NextPage.update => UpdatePage.path,
      };
}