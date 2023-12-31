import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/auth/data/repo/auth_repo_impl.dart';
import 'package:eng_shop/features/auth/domain/repo/auth_repo.dart';

import '../entity/login_entity.dart';

class LoginUsecase implements Usecase<LoginEntity,LoginParams> {
  AuthRepo repo ;

  LoginUsecase({required this.repo});

  @override
  Future<Either<Failure, LoginEntity>> call(LoginParams params) async {
    return await repo.login(params.email, params.password,params.isMobile,params.screenCode);
  }
}

class LoginParams {
  String email;
  String password;
  bool isMobile;
  int screenCode;

  LoginParams(this.email, this.password, this.isMobile, this.screenCode);


}