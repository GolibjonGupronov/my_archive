import 'package:my_archive/core/enums/gender.dart';

class UserInfoEntity {
  final String firstName;
  final String secondName;
  final Gender gender;
  final String birthday;

  UserInfoEntity({
    required this.firstName,
    required this.secondName,
    required this.gender,
    required this.birthday,
  });
}
