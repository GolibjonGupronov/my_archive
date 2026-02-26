import 'package:my_archive/core/constants/constants.dart';

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
