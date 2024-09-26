import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hidaya/data/model/user/userModel.dart';

abstract class UserService {
  Future<DocumentReference<Map<String, dynamic>>> getUser();
  Future updateUser(Usermodel userModel);
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserName();
}

class UserServiceImpl extends UserService {
  @override
  Future<DocumentReference<Map<String, dynamic>>> getUser() async {
    final user = FirebaseAuth.instance.currentUser;

    final result =
        await FirebaseFirestore.instance.collection('User').doc(user!.uid);

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
}
