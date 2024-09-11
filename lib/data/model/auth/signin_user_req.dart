class SigninUserReq {
  final String fullname;
  final String email;
  final String password;

  SigninUserReq(
      {required this.fullname, required this.email, required this.password});
}
