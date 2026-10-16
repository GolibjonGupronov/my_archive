import 'package:my_archive/core/enums/common.dart';
import 'package:my_archive/core/extensions/common.dart';

class EditProfileParams {
  final String firstName;
  final String secondName;
  final Gender gender;
  final DateTime birthDay;

  const EditProfileParams({
    required this.firstName,
    required this.secondName,
    required this.gender,
    required this.birthDay,
  });

  Map<String, dynamic> get toMap => {
        'first_name': firstName,
        'second_name': secondName,
        'gender': gender.key,
        'birthday': birthDay.toBackendDate,
      };
}
