class LoginParams {
  final String phone;
  final String password;

  LoginParams({required this.phone, required this.password});

  Map<String, dynamic> get toMap => {
        'phone': phone,
        'password': password,
      };
}
