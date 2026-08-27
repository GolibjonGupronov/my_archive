class UnAuthorizedException implements Exception {
  final String message;

  UnAuthorizedException({this.message = "Sessiya muddati tugagan yoki boshqa qurilmadan o'chirilgan"});
}
