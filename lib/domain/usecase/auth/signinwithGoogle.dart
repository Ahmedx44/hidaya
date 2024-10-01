import 'package:dartz/dartz.dart';

import 'package:hidaya/domain/respository/auth/auth_repsoitory.dart';
import 'package:hidaya/service_locator.dart';

class SignInWithGoogle {
  Future<Either<String, String>> call() async {
    return sl<AuthRepsoitory>().signinWithGoogle();
  }
}
