import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRepository {
  User getUser();
}
