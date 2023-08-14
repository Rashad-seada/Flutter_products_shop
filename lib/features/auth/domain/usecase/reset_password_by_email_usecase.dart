import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/auth/domain/entity/reset_password_by_email_entity.dart';

import '../repo/auth_repo.dart';

class ResetPasswordByEmailUsecase implements Usecase<ResetPasswordByEmailEntity,ResetPasswordByEmailParams> {

  AuthRepo repo;
  ResetPasswordByEmailUsecase({required this.repo});

  @override
  Future<Either<Failure, ResetPasswordByEmailEntity>> call(ResetPasswordByEmailParams params) async {
    return await repo.resetPasswordByEmail(params.email, params.screenCode);
  }

}

class ResetPasswordByEmailParams {
  String email;
  int screenCode;

  ResetPasswordByEmailParams(this.email,this.screenCode);
}