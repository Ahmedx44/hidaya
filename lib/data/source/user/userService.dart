import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hidaya/data/model/user/userModel.dart';

abstract class UserService {
  DocumentReference<Map<String, dynamic>> getUser();
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData();
  Future updateUser(Usermodel userModel);
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserName();
}

class UserServiceImpl extends UserService {
  @override
  DocumentReference<Map<String, dynamic>> getUser() {
    final user = FirebaseAuth.instance.currentUser;

    final result = FirebaseFirestore.instance.collection('User').doc(user!.uid);

    return result;
  }

  @override
  Future updateUser(Usermodel userModel) async {
    final user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('User').doc(user!.uid).update({
      'email': userModel.email,
      'fullName': userModel.fullName,
      'phone': userModel.phoneNumber,
      'imageUrl': userModel.imageUrl
    });
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserName() async {
    final userId = FirebaseAuth.instance;
    final user = await FirebaseFirestore.instance
        .collection('User')
        .doc(userId.currentUser!.uid)
        .get();
    return user;
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() {
    final user = FirebaseAuth.instance.currentUser;

    final result =
        FirebaseFirestore.instance.collection('User').doc(user!.uid).get();

    return result;
  }
}
