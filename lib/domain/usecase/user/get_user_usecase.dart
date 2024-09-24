import 'package:firebase_auth/firebase_auth.dart';
import 'package:hidaya/data/source/user/userService.dart';
import 'package:hidaya/service_locator.dart';

class GetUserUsecase {
  Future<User> call() {
    return sl<UserService>().getUser();
  }
}
