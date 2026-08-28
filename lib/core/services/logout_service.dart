import 'package:my_archive/core/exports/core_exports.dart';
import 'package:my_archive/core/exports/route_exports.dart';
import 'package:my_archive/core/local_storage/remove_storage.dart';
import 'package:my_archive/core/services/notification_service.dart';

class LogoutService {
  LogoutService._();

  static Future<void> logoutApp() async {
    await RemoveStorage.logoutApp();
    await NotificationService.deleteFCMToken;
    router.go(SplashPage.tag);
  }
}
