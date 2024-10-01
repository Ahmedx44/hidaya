import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hidaya/data/model/auth/create_user_req.dart';
import 'package:hidaya/data/model/auth/signin_user_req.dart';

abstract class AuthRepsoitory {
  Future<Either> signin(SigninUserReq signinUserReq);
  Future<Either> signup(CreateUserReq createUserReq);
  Future<Either<String, User>> signinWithApple();
  Future<Either<String, String>> signinWithGoogle();
}
