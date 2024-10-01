import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hidaya/domain/respository/auth/auth_repsoitory.dart';
import 'package:hidaya/service_locator.dart';

class SignInWithApple {
  Future<Either<String, User>> call() async {
    return sl<AuthRepsoitory>().signinWithApple();
  }
}
