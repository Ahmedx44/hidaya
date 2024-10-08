import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hidaya/data/source/user/userService.dart';
import 'package:hidaya/domain/respository/user/user_repository.dart';
import 'package:hidaya/service_locator.dart';

class UserRepositoryImpl extends UserRepository {
  @override
  DocumentReference<Map<String, dynamic>> getUser() {
    return sl<UserService>().getUser();
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserName() {
    return sl<UserService>().getUserName();
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() {
    return sl<UserService>().getUserData();
  }

  @override
  Future<String> followUser(String email) {
    return sl<UserService>().followUser(email);
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getUserProfile(String userId) {
    return sl<UserService>().getUserProfile(userId);
  }
}
