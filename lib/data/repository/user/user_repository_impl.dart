import 'package:firebase_auth/firebase_auth.dart';
import 'package:hidaya/data/source/user/userService.dart';
import 'package:hidaya/domain/respository/user/user_repository.dart';
import 'package:hidaya/service_locator.dart';

class UserRepositoryImpl extends UserRepository {
  @override
  Future<User> getUser() async {
    return await sl<UserService>().getUser();
  }
}
