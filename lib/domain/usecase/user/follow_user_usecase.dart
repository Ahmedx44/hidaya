import 'package:hidaya/data/source/user/userService.dart';
import 'package:hidaya/service_locator.dart';

class FollowUserUsecase {
  Future<String> call(param) {
    return sl<UserService>().followUser(param);
  }
}
