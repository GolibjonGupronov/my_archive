import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiUrls {
  static final String baseUrl = dotenv.env['MAIN_URL']!;
  static final String api = dotenv.env['API_PATH']!;

  static final String appConfig = "$api/app_config/";
  static final String sendPhone = "$api/auth/send-phone/";
  static final String checkSms = "$api/auth/check-sms/";
  static final String userInfo = "$api/user/me/";
}
