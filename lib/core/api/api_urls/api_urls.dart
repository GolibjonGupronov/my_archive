import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiUrls {
  static final String baseUrl = dotenv.env['MAIN_URL']!;
  static final String _api = dotenv.env['API_PATH']!;

  static final String appConfig = "$_api/app_config";
  static final String sendLogin = "$_api/auth/send-login";
  static final String sendPhone = "$_api/auth/send-phone";
  static final String checkSms = "$_api/auth/check-sms";
  static final String userInfo = "$_api/user/me";
  static final String registration = "$_api/user/registration";
  static final String changeImage = "$_api/user/change-image";
  static final String oldPassword = "$_api/old-password";
  static final String newPassword = "$_api/new-password";
  static final String editProfile = "$_api/edit-profile";
  static final String storyList = "$_api/story_list";
  static final String deviceSessionList = "$_api/device_session_list";
  static final String terminateDevice = "$_api/terminate_device";
  static final String enableNotification = "$_api/enable_notification";
}
