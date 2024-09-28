import 'package:hidaya/data/source/user/userService.dart';
import 'package:hidaya/service_locator.dart';

class UnfollowUserUsecase {
  Future<String> call(param) {
    return sl<UserService>().unfollowuser(param);
  }
}
