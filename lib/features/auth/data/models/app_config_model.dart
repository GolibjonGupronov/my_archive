import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_archive/features/auth/domain/entities/app_config_entity.dart';

class AppConfigModel extends AppConfigEntity {
  AppConfigModel({
    required super.iosMinimumBuildCode,
    required super.androidMinimumBuildCode,
    required super.googlePlayLink,
    required super.appStoreLink,
    required super.callCenter,
    required super.telegramBot,
    required super.telegram,
    required super.instagram,
    required super.facebook,
    required super.serverDate,
  });

  factory AppConfigModel.fromJson(Map<String, dynamic> json) {
    String serverDate = "";
    final date = json['server_date'];
    if (date is Timestamp) {
      serverDate = date.toDate().toIso8601String();
    } else if (date is String) {
      serverDate = date;
    }
    return AppConfigModel(
      iosMinimumBuildCode: json['ios_minimum_build_code'] ?? 1,
      androidMinimumBuildCode: json['android_minimum_build_code'] ?? 1,
      googlePlayLink: json['google_play_link'] ?? "",
      appStoreLink: json['app_store_link'] ?? "",
      callCenter: json['call_center'] ?? "",
      telegramBot: json['telegram_bot'] ?? "",
      telegram: json['telegram'] ?? "",
      instagram: json['instagram'] ?? "",
      facebook: json['facebook'] ?? "",
      serverDate: serverDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ios_minimum_build_code': iosMinimumBuildCode,
      'android_minimum_build_code': androidMinimumBuildCode,
      'google_play_link': googlePlayLink,
      'app_store_link': appStoreLink,
      'call_center': callCenter,
      'telegram_bot': telegramBot,
      'telegram': telegram,
      'instagram': instagram,
      'facebook': facebook,
      'server_date': serverDate,
    };
  }
}
