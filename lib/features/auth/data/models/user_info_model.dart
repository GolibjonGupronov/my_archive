import 'package:my_archive/core/enums/common.dart';
import 'package:my_archive/features/auth/domain/entities/user_info_entity.dart';

class UserInfoModel extends UserInfoEntity {
  UserInfoModel({
    required super.firstName,
    required super.secondName,
    required super.gender,
    required super.birthday,
    required super.phone,
    required super.image,
    required super.isNotificationEnabled,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
        firstName: json['first_name'] as String,
        secondName: json['second_name'] as String,
        gender: Gender.getObj(json['gender'] as String),
        birthday: json['birthday'] as String,
        phone: json['phone'] as String,
        image: json['image'] as String,
        isNotificationEnabled: json['is_notification_enabled'] as bool,
      );

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'second_name': secondName,
        'gender': gender.key,
        'birthday': birthday,
        'phone': phone,
        'image': image,
        'is_notification_enabled': isNotificationEnabled,
      };
}
