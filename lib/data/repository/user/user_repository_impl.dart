import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hidaya/data/source/user/userService.dart';
import 'package:hidaya/domain/respository/user/user_repository.dart';
import 'package:hidaya/service_locator.dart';

class UserRepositoryImpl extends UserRepository {
  @override
  Future<DocumentReference<Map<String, dynamic>>> getUser() async {
    return await sl<UserService>().getUser();
  }
}
