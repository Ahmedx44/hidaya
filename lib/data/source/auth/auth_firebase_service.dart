import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hidaya/data/model/auth/create_user_req.dart';
import 'package:hidaya/data/model/auth/signin_user_req.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

abstract class AuthFirebaseService {
  Future<Either<String, String>> signin(SigninUserReq signinUserReq);
  Future<Either<String, String>> signup(CreateUserReq createUserReq);
  Future<Either<String, String>> signinWithGoogle();
  Future<Either<String, User>> signinWithApple();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  final _auth = FirebaseAuth.instance;

  @override
  Future<Either<String, String>> signin(SigninUserReq signinUserReq) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: signinUserReq.email,
        password: signinUserReq.password,
      );
      return const Right('Successfully Logged in');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'user-not-found') {
        message = 'No user found with this email';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided';
      }
      return Left(message);
    }
  }

  @override
  Future<Either<String, String>> signup(CreateUserReq createUserReq) async {
    try {
      UserCredential userData = await _auth.createUserWithEmailAndPassword(
        email: createUserReq.email,
        password: createUserReq.password,
      );

      await FirebaseFirestore.instance
          .collection('User')
          .doc(userData.user!.uid)
          .set({
        'fullName': createUserReq.fullname,
        'email': createUserReq.email,
        'phone': '',
        'imageUrl': '',
        'heatmap': [],
        'followers': [],
        'following': [],
        'requests': [],
      });

      return const Right('Successfully Signed up');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'Your password is very weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with this email';
      } else {
        message = 'There was an error';
      }
      return Left(message);
    }
  }

  @override
  Future<Either<String, String>> signinWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount == null) {
        return const Left('Google sign-in was canceled');
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      UserCredential result = await _auth.signInWithCredential(credential);
      User? userDetail = result.user;

      if (userDetail != null) {
        Map<String, dynamic> userInfoMap = {
          'email': userDetail.email,
          'fullName': userDetail.displayName,
          'imageUrl': userDetail.photoURL,
          'id': userDetail.uid,
          'heatmap': [],
          'followers': [],
          'following': [],
          'requests': [],
        };

        await FirebaseFirestore.instance
            .collection('User')
            .doc(userDetail.uid)
            .set(userInfoMap, SetOptions(merge: true));

        return const Right('Successfully signed in with Google');
      } else {
        return const Left('Failed to sign in with Google');
      }
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? 'Google Sign-In failed');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, User>> signinWithApple(
      {List<Scope> scopes = const []}) async {
    try {
      final result = await TheAppleSignIn.performRequests(
          [AppleIdRequest(requestedScopes: scopes)]);

      switch (result.status) {
        case AuthorizationStatus.authorized:
          final AppleIdCredential = result.credential!;
          final oAuthProvider = OAuthProvider('apple.com');
          final credential = oAuthProvider.credential(
              idToken: String.fromCharCodes(AppleIdCredential.identityToken!));

          final UserCredential userCredential =
              await FirebaseAuth.instance.signInWithCredential(credential);

          final firebaseUser = userCredential.user;

          if (scopes.contains(Scope.fullName)) {
            final fullName = AppleIdCredential.fullName;

            if (fullName != null &&
                fullName.givenName != null &&
                fullName.familyName != null) {
              final displayName =
                  '${fullName.givenName} ${fullName.familyName}';
              await firebaseUser!.updateDisplayName(displayName);
            }
          }

          return Right(firebaseUser!);

        case AuthorizationStatus.error:
          return Left('Authorization error: ${result.error.toString()}');

        case AuthorizationStatus.cancelled:
          return Left('Sign-in aborted by the user');

        default:
          return Left('Unexpected error during Apple sign-in');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
