import 'package:firebase_auth/firebase_auth.dart';
import 'package:hidaya/data/source/user/userService.dart';
import 'package:hidaya/domain/respository/user/user_repository.dart';
import 'package:hidaya/service_locator.dart';

class UserRepositoryImpl extends UserRepository {
  @override
  User getUser() {
    return sl<UserService>().getUser();
  }
}
