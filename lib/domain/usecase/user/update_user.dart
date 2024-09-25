import 'package:hidaya/data/model/user/userModel.dart';
import 'package:hidaya/data/source/user/userService.dart';
import 'package:hidaya/service_locator.dart';

class UpdateUser {
  Future call(Usermodel params) {
    return sl<UserService>().updateUser(params);
  }
}
