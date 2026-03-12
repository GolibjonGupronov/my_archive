import 'dart:async';
import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_alice/alice.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:overlay_support/overlay_support.dart';

final Alice alice = Alice(showNotification: false);
final GlobalKey<OverlayState> overlayKey = GlobalKey<OverlayState>();
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
          fallbackLocale: sl.get<PrefManager>().getLanguage.locale,
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Offset _offset = const Offset(32, 48);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addFloatingButton();
    });

    super.initState();
  }

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
              routeInformationParser: router.routeInformationParser,
              routeInformationProvider: router.routeInformationProvider,
              routerDelegate: router.routerDelegate,
              builder: (context, child) => ScrollConfiguration(
                behavior: NoGlowScrollBehavior(),
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
                  child: Overlay(key: overlayKey, initialEntries: [OverlayEntry(builder: (_) => child!)]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  OverlayEntry? _debugOverlayEntry;

  void _addFloatingButton() async {
    if (_debugOverlayEntry != null) return;

    _debugOverlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: _offset.dy,
        left: _offset.dx,
        child: Visibility(
          visible: _check(),
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() => _offset += details.delta);
            },
            child: Row(
              spacing: 14,
              children: [
                GestureDetector(
                  onTap: () => alice.showInspector(),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                    child: const Icon(Icons.http, color: Colors.white),
                  ),
                ),
                GestureDetector(
                  onTap: () => _changeLanguage(),
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                      child: Center(child: Text(sl.get<PrefManager>().getLanguage.key, style: TextStyle(color: AppColors.white))),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    AdaptiveTheme.of(context).toggleThemeMode(useSystem: false);
                    _debugOverlayEntry?.markNeedsBuild();
                  },
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                      child: Center(
                        child: Icon(
                          AdaptiveTheme.of(context).mode.isDark ? Icons.light_mode : Icons.dark_mode,
                          color: AppColors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    Timer(Duration(seconds: 3), () {
      overlayKey.currentState?.insert(_debugOverlayEntry!);
    });
  }

  void _changeLanguage() async {
    final pref = sl.get<PrefManager>();
    final currentLang = pref.getLanguage;
    final next = currentLang.next;
    pref.setLanguage(next);
    context.setLocale(next.locale);
    // await Get.updateLocale(next.locale);
    // await initializeDateFormatting(next.key);
    _debugOverlayEntry?.markNeedsBuild();
  }
}

bool _check() {
  return kDebugMode;
}

class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
