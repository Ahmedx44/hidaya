import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UserRepository {
  Future<DocumentReference<Map<String, dynamic>>> getUser();
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserName();
}
