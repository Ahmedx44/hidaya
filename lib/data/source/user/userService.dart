import 'package:firebase_auth/firebase_auth.dart';

abstract class UserService {
  User getUser();
}

class UserServiceImpl extends UserService {
  @override
  User getUser() {
    final user = FirebaseAuth.instance.currentUser;
    return user!;
  }
}
