import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UserRepository {
  DocumentReference<Map<String, dynamic>> getUser();
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserName();
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData();
  Future<String> followUser(String email);
}
