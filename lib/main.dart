import 'dart:async';
import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_alice/alice.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/core/widgets/common/floating_buttons.dart';
import 'package:overlay_support/overlay_support.dart';

final Alice alice = Alice(showNotification: false);
AdaptiveThemeMode? savedThemeMode;

void main() {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await EasyLocalization.ensureInitialized();
      await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      await InjectionContainer.init();
      await DeviceHelper.init();

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
              // routeInformationParser: router.routeInformationParser,
              // routeInformationProvider: router.routeInformationProvider,
              // routerDelegate: router.routerDelegate,
              builder: (context, child) => ScrollConfiguration(
                behavior: NoGlowScrollBehavior(),
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
                  child: Overlay(initialEntries: [
                    OverlayEntry(builder: (_) => child!),
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
