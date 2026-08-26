import 'package:my_archive/core/core_exports.dart';

class UserInfoEntity {
  final String firstName;
  final String secondName;
  final Gender gender;
  final String birthday;
  final String phone;
  final String image;
  final bool isNotificationEnabled;

  UserInfoEntity({
    required this.firstName,
    required this.secondName,
    required this.gender,
    required this.birthday,
    required this.phone,
    required this.image,
    required this.isNotificationEnabled,
  });

  String get fullName => "$firstName\n$secondName";
}
