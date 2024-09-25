import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hidaya/data/source/user/userService.dart';
import 'package:hidaya/service_locator.dart';

class GetUserUsecase {
  Future<DocumentReference<Map<String, dynamic>>> call() {
    return sl<UserService>().getUser();
  }
}
