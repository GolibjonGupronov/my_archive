import 'package:my_archive/core/app_router/route_exports.dart';

enum BottomNavMainPage { home, profile }

enum NextPage {
  auth,
  main,
  update;

  String get page => switch (this) {
        NextPage.auth => LoginPage.tag,
        NextPage.main => MainPage.tag,
        NextPage.update => UpdatePage.tag,
      };
}
