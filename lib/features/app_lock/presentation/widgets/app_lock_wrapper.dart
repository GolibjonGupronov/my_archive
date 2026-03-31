import 'package:flutter/material.dart';
import 'package:my_archive/core/app_router/route_exports.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/core/local_storage/secure_storage.dart';

class AppLockWrapper extends StatefulWidget {
  final Widget child;

  const AppLockWrapper({super.key, required this.child});

  @override
  State<AppLockWrapper> createState() => _AppLockWrapperState();
}

class _AppLockWrapperState extends State<AppLockWrapper> with WidgetsBindingObserver {
  DateTime? _pausedAt;
  int _count = 0;
  bool _isShowingLock = false;
  final PrefManager _prefManager = sl.get<PrefManager>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint("GGQ => AppLifecycleState $state");
    if (state == AppLifecycleState.paused) {
      _count = 0;
      _pausedAt = DateTime.now();
    }

    if (state == AppLifecycleState.resumed) {
      if (_pausedAt == null || _count > 0) return;
      _count++;
      final diff = DateTime.now().difference(_pausedAt!);
      final currentLocation = router.routerDelegate.currentConfiguration.uri.toString();
      if (diff > Duration(seconds: _prefManager.getAutoLockTime.seconds) &&
          currentLocation != SplashPage.tag &&
          currentLocation != AppLockPage.tag) {
        _openLockIfNeeded();
      }
    }
  }

  Future<void> _openLockIfNeeded() async {
    if (_isShowingLock) return;

    final hasCode = await sl.get<SecureStorage>().hasPin();

    if (!hasCode) return;

    _isShowingLock = true;

    router.push(AppLockPage.tag).then((result) {
      _isShowingLock = false;

      if (result != true) {
        Future.delayed(const Duration(milliseconds: 300), () {
          _openLockIfNeeded();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
