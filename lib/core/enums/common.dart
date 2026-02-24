import 'package:my_archive/core/app_router/route_exports.dart';

enum NextPage { auth, main, update }

enum AuthNextPage {
  sms,
  registration;

  String get page => switch (this) {
        AuthNextPage.sms => SmsPage.tag,
        AuthNextPage.registration => RegistrationPage.tag,
      };
}
