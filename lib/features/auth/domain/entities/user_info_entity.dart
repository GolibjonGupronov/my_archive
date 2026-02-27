import 'package:my_archive/core/enums/gender.dart';

class UserInfoEntity {
  final String firstName;
  final String secondName;
  final Gender gender;
  final String birthday;
  final String phone;

  UserInfoEntity({
    required this.firstName,
    required this.secondName,
    required this.gender,
    required this.birthday,
    required this.phone,
  });
}
