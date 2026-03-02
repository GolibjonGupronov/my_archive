import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/auth/domain/entities/user_info_entity.dart';

class UserInfoModel extends UserInfoEntity {
  UserInfoModel({
    required super.firstName,
    required super.secondName,
    required super.gender,
    required super.birthday,
    required super.phone,
    required super.image,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
        firstName: json['first_name'] ?? "",
        secondName: json['second_name'] ?? "",
        gender: Gender.getObj(json['gender'] ?? ""),
        birthday: json['birthday'] ?? "",
        phone: json['phone'] ?? "",
        image: json['image'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'second_name': secondName,
        'gender': gender.key,
        'birthday': birthday,
        'phone': phone,
        'image': image,
      };

  UserInfoEntity toEntity() => UserInfoEntity(
        firstName: firstName,
        secondName: secondName,
        gender: gender,
        birthday: birthday,
        phone: phone,
        image: image,
      );
}
