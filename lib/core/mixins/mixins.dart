import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_archive/core/core_exports.dart';

mixin RefreshCooldownMixin {
  DateTime? _lastRefreshTime;

  bool get canRefresh {
    final now = DateTime.now();

    if (_lastRefreshTime != null) {
      final diff = now.difference(_lastRefreshTime!).inSeconds;

      if (diff < Constants.refreshSeconds) {
        // final remaining = AppConstants.refreshSeconds - diff;
        // CustomToast.showLast("Iltimos $remaining soniya kuting");
        return false;
      }
    }

    _lastRefreshTime = now;
    return true;
  }
}

mixin ExitAppMixin {
  DateTime? _lastBackPressed;

  bool onExitApp(BuildContext context, {int seconds = 2}) {
    final now = DateTime.now();

    if (_lastBackPressed == null || now.difference(_lastBackPressed!) > Duration(seconds: seconds)) {
      _lastBackPressed = now;
      showInfoToast(context, tr('again_to_exit'), second: seconds, isDismissible: false);
      return false;
    }
    return true;
  }
}
