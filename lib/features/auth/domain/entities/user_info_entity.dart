import 'package:my_archive/core/core_exports.dart';

class UserInfoEntity {
  final String firstName;
  final String secondName;
  final Gender gender;
  final String birthday;
  final String phone;
  final String image;
  final bool isNotificationEnabled;
  final String callCenter;
  final String telegramBot;

  UserInfoEntity({
    required this.firstName,
    required this.secondName,
    required this.gender,
    required this.birthday,
    required this.phone,
    required this.image,
    required this.isNotificationEnabled,
    required this.callCenter,
    required this.telegramBot,
  });

  String get fullName => "$firstName\n$secondName";
}
