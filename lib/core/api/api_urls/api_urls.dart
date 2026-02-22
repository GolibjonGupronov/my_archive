import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiUrls {
  static final String baseUrl = dotenv.env['MAIN_URL']!;
  static final String api = dotenv.env['API_PATH']!;

  static final String sendPhone = "$api/auth/sign-in/";
  // static final String sendPhone = "$api/patients/sendPhone";
}