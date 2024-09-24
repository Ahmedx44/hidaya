import 'package:firebase_auth/firebase_auth.dart';

abstract class UserService {
  Future<User> getUser();
}

class UserServiceImpl extends UserService {
  @override
  Future<User> getUser() async {
    final user = FirebaseAuth.instance.currentUser;

    return user!;
  }
}
