import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/auth/domain/entity/reset_password_entity.dart';

import '../../data/repo/auth_repo_impl.dart';
import '../repo/auth_repo.dart';

class ResetPasswordUsecase implements Usecase<ResetPasswordEntity,ResetPasswordParams> {

  AuthRepo repo = AuthRepoImpl();

  @override
  Future<Either<Failure, ResetPasswordEntity>> call(ResetPasswordParams params) async {
    return await repo.resetPassword(params.phoneNumber, params.smsCode, params.newPassword);
  }

}

class ResetPasswordParams {
  String phoneNumber;
  String smsCode;
  String newPassword;

  ResetPasswordParams(this.phoneNumber, this.smsCode, this.newPassword);
}