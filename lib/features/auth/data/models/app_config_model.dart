import 'package:my_archive/features/auth/domain/entities/app_config_entity.dart';

class AppConfigModel extends AppConfigEntity {
  AppConfigModel(
      {required super.iosMinimumBuildCode,
      required super.androidMinimumBuildCode,
      required super.googlePlayLink,
      required super.appStoreLink});

  factory AppConfigModel.fromJson(Map<String, dynamic> json) {
    return AppConfigModel(
      iosMinimumBuildCode: json['ios_minimum_build_code'],
      androidMinimumBuildCode: json['android_minimum_build_code'],
      googlePlayLink: json['google_play_link'],
      appStoreLink: json['app_store_link'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ios_minimum_build_code': iosMinimumBuildCode,
      'android_minimum_build_code': androidMinimumBuildCode,
      'google_play_link': googlePlayLink,
      'app_store_link': appStoreLink,
    };
  }
}
