class CreateUserReq {
  final String fullname;
  final String email;
  final String password;

  CreateUserReq(
      {required this.fullname, required this.email, required this.password});
}
