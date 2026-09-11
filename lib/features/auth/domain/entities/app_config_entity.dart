class AppConfigEntity {
  final int iosMinimumBuildCode;
  final int androidMinimumBuildCode;
  final String googlePlayLink;
  final String appStoreLink;
  final String callCenter;
  final String telegramBot;
  final String telegram;
  final String instagram;
  final String facebook;
  final String serverDate;

  const AppConfigEntity({
    required this.iosMinimumBuildCode,
    required this.androidMinimumBuildCode,
    required this.googlePlayLink,
    required this.appStoreLink,
    required this.callCenter,
    required this.telegramBot,
    required this.telegram,
    required this.instagram,
    required this.facebook,
    required this.serverDate,
  });
}
