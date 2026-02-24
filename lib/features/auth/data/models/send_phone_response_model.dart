import 'package:my_archive/features/auth/domain/entities/send_phone_response_entity.dart';

class SendPhoneResponseModel extends SendPhoneResponseEntity {
  SendPhoneResponseModel({required super.phone, required super.isRegistered});

  factory SendPhoneResponseModel.fromJson(Map<String, dynamic> json) => SendPhoneResponseModel(
        phone: json["phone"] ?? "",
        isRegistered: json["is_registered"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "is_registered": isRegistered,
      };

  SendPhoneResponseEntity toEntity() => SendPhoneResponseEntity(
        phone: phone,
    isRegistered: isRegistered,
  );
}
