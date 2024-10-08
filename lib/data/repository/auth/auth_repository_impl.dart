import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hidaya/data/model/auth/create_user_req.dart';
import 'package:hidaya/data/model/auth/signin_user_req.dart';
import 'package:hidaya/data/source/auth/auth_firebase_service.dart';
import 'package:hidaya/domain/respository/auth/auth_repsoitory.dart';
import 'package:hidaya/service_locator.dart';

class AuthRepositoryImpl extends AuthRepsoitory {
  @override
  Future<Either> signin(SigninUserReq signinUserReq) async {
    return await sl<AuthFirebaseService>().signin(signinUserReq);
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    return await sl<AuthFirebaseService>().signup(createUserReq);
  }

  @override
  Future<Either<String, User>> signinWithApple() async {
    return await sl<AuthFirebaseService>().signinWithApple();
  }

  @override
  Future<Either<String, String>> signinWithGoogle() async {
    return await sl<AuthFirebaseService>().signinWithGoogle();
  }
}
