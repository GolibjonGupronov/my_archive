class SendPhoneResponseEntity {
  final String phone;
  final String token;
  final bool isRegistered;

  const SendPhoneResponseEntity({required this.phone, required this.token, required this.isRegistered});
}
