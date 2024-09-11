import 'package:dartz/dartz.dart';
import 'package:hidaya/core/usecase/usecase.dart';
import 'package:hidaya/data/model/auth/signin_user_req.dart';
import 'package:hidaya/domain/respository/auth/auth_repsoitory.dart';
import 'package:hidaya/service_locator.dart';

class SigininUsecase implements Usecase<Either, SigninUserReq> {
  @override
  Future<Either> call({SigninUserReq? params}) {
    return sl<AuthRepsoitory>().signin(params!);
  }
}
