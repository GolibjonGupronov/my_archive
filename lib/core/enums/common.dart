import 'package:my_archive/core/app_router/route_exports.dart';

enum BottomNavMainPage { home, profile }

enum NextPage {
  auth,
  main,
  setup,
  update;

  String get page => switch (this) {
        NextPage.auth => PhonePage.tag,
        NextPage.main => MainPage.tag,
        NextPage.setup => SetupPage.tag,
        NextPage.update => UpdatePage.tag,
      };
}

enum AuthNextPage {
  sms,
  registration;

  String get page => switch (this) {
        AuthNextPage.sms => SmsPage.tag,
        AuthNextPage.registration => RegistrationPage.tag,
      };
}
