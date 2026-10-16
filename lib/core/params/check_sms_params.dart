class CheckSmsParams {
  final String phone;
  final String sms;

  CheckSmsParams({required this.phone, required this.sms});

  Map<String, dynamic> get toMap => {
        'phone': phone,
        'sms': sms,
      };
}
