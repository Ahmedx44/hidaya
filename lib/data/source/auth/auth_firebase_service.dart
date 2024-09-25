import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hidaya/data/model/auth/create_user_req.dart';
import 'package:hidaya/data/model/auth/signin_user_req.dart';

abstract class AuthFirebaseService {
  Future<Either> signin(SigninUserReq signinUserReq);
  Future<Either> signup(CreateUserReq createinUserReq);
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  final _auth = FirebaseAuth.instance;
  @override
  Future<Either> signin(SigninUserReq signinUserReq) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: signinUserReq.email, password: signinUserReq.password);
      return const Right('Succefully Logedin');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'Invalid-email') {
        message = 'No user found with this email';
      } else if (e.code == 'invalid-credential') {
        message = 'Wrong password provided';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> signup(CreateUserReq createinUserReq) async {
    try {
      UserCredential userData = await _auth.createUserWithEmailAndPassword(
          email: createinUserReq.email, password: createinUserReq.password);

      await FirebaseFirestore.instance
          .collection('User')
          .doc(userData.user!.uid)
          .set({
        'fullname': createinUserReq.fullname,
        'email': createinUserReq.email,
        'phone': '',
        'imageUrl': ''
      });

      return const Right('Succefully created');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'Your password is very weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'An acount already existed with this email';
      } else {
        message = 'There is an error';
      }
      return Left(message);
    }
  }
}
