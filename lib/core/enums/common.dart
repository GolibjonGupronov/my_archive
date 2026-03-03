import 'package:my_archive/core/app_router/route_exports.dart';

enum BottomNavMainPage { home, profile }

enum NextPage {
  auth,
  main,
  setup,
  update;

  String get page => switch (this) {
        NextPage.auth => LoginPage.tag,
        NextPage.main => MainPage.tag,
        NextPage.setup => SetupPage.tag,
        NextPage.update => UpdatePage.tag,
      };
}
