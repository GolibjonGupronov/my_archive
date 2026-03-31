import 'dart:async';
import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_alice/alice.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/core/services/notification_service.dart';
import 'package:my_archive/core/widgets/common/floating_buttons.dart';
import 'package:my_archive/features/app_lock/presentation/widgets/app_lock_wrapper.dart';
import 'package:overlay_support/overlay_support.dart';

final Alice alice = Alice(showNotification: false);
AdaptiveThemeMode? savedThemeMode;

@pragma('vm:entry-point')
Future<void> backgroundHandler(RemoteMessage msg) async {
  await Firebase.initializeApp();
  NotificationService.showNotification(msg);
}

void main() {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await EasyLocalization.ensureInitialized();
      await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      await InjectionContainer.init();
      await DeviceHelper.init();
      await Firebase.initializeApp();
      await NotificationService.init();
      FirebaseMessaging.onBackgroundMessage(backgroundHandler);

      savedThemeMode = await AdaptiveTheme.getThemeMode();

      alice.setNavigatorKey(globalNavigatorKey);
      FlutterError.onError = (FlutterErrorDetails details) {
        catchUnhandledExceptions(
          details.exception,
          details.stack,
          fatal: !(details.exception is HttpException ||
              details.exception is SocketException ||
              details.exception is HandshakeException ||
              details.exception is ClientException),
        );
      };

      ErrorWidget.builder = (FlutterErrorDetails details) {
        BotService.sendMobileBug(details);
        return ErrorPage(errorDetails: details);
      };

      runApp(EasyLocalization(
          supportedLocales: LangType.values.map((e) => e.locale).toList(),
          path: 'assets/languages',
          startLocale: sl.get<PrefManager>().getLanguage.locale,
          fallbackLocale: const Locale('uz'),
          child: MyApp()));
    },
    (error, stackTrace) {
      catchUnhandledExceptions(error, stackTrace, fatal: false);
    },
  );
}

void catchUnhandledExceptions(Object error, StackTrace? stack, {bool fatal = true}) {
  debugPrintStack(stackTrace: stack, label: error.toString());
  try {
    // FirebaseCrashlytics.instance.recordError(error, stack, fatal: fatal);
    debugPrintStack(stackTrace: stack, label: error.toString());
  } catch (_) {}
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (context, child) => OverlaySupport.global(
        child: AdaptiveTheme(
          light: AppTheme.lightTheme,
          dark: AppTheme.darkTheme,
          initial: savedThemeMode ?? AdaptiveThemeMode.light,
          builder: (ThemeData light, ThemeData dark) {
            return MaterialApp.router(
              title: 'My Archive',
              theme: light,
              darkTheme: dark,
              locale: context.locale,
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              routerConfig: router,
              builder: (context, child) => ScrollConfiguration(
                behavior: NoGlowScrollBehavior(),
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
                  child: Overlay(initialEntries: [
                    OverlayEntry(builder: (_) => AppLockWrapper(child: child!)),
                    OverlayEntry(builder: (_) => FloatingButtons()),
                  ]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) => child;
}
