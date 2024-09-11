import 'package:dartz/dartz.dart';
import 'package:hidaya/core/usecase/usecase.dart';
import 'package:hidaya/data/model/auth/create_user_req.dart';
import 'package:hidaya/domain/respository/auth/auth_repsoitory.dart';
import 'package:hidaya/service_locator.dart';

class SignupUsecase implements Usecase<Either, CreateUserReq> {
  @override
  Future<Either> call({CreateUserReq? params}) {
    return sl<AuthRepsoitory>().signup(params!);
  }
}
