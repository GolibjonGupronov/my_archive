class AppConfigEntity {
  final int iosMinimumBuildCode;
  final int androidMinimumBuildCode;
  final String googlePlayLink;
  final String appStoreLink;

  const AppConfigEntity({
    required this.iosMinimumBuildCode,
    required this.androidMinimumBuildCode,
    required this.googlePlayLink,
    required this.appStoreLink,
  });
}
