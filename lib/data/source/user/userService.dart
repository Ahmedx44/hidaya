import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserService {
  Future<DocumentReference<Map<String, dynamic>>> getUser();
}

class UserServiceImpl extends UserService {
  @override
  Future<DocumentReference<Map<String, dynamic>>> getUser() async {
    final user = FirebaseAuth.instance.currentUser;

    final result =
        await FirebaseFirestore.instance.collection('User').doc(user!.uid);

    return result;
  }
}
