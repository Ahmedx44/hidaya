import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hidaya/data/source/user/userService.dart';
import 'package:hidaya/service_locator.dart';

class GetUserProfileUsecase {
  Stream<QuerySnapshot<Map<String, dynamic>>> call(param) {
    return sl<UserService>().getUserProfile(param);
  }
}
