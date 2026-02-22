import 'package:my_archive/features/auth/domain/entities/send_phone_response_entity.dart';

class SendPhoneResponseModel extends SendPhoneResponseEntity {
  SendPhoneResponseModel({required super.phone, required super.isRegistered, required super.token});

  factory SendPhoneResponseModel.fromJson(Map<String, dynamic> json) {
    return SendPhoneResponseModel(
      phone: json["phone"] ?? "",
      token: json["token"] ?? "",
      isRegistered: json["is_registered"] ?? false,
    );
  }

  SendPhoneResponseEntity get toEntity => SendPhoneResponseEntity(
    phone: phone,
    token: token,
    isRegistered: isRegistered,
  );
}
