import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/auth/domain/entity/reset_password_by_sms_entity.dart';

import '../repo/auth_repo.dart';

class ResetPasswordBySMSUsecase implements Usecase<ResetPasswordBySMSEntity,ResetPasswordBySMSParams> {

  AuthRepo repo;
  ResetPasswordBySMSUsecase({required this.repo});

  @override
  Future<Either<Failure, ResetPasswordBySMSEntity>> call(ResetPasswordBySMSParams params) async {
    return await repo.resetPasswordBySMS(params.phoneNumber, params.smsCode, params.newPassword,params.screenCode);
  }

}

class ResetPasswordBySMSParams {
  String phoneNumber;
  String smsCode;
  String newPassword;
  int screenCode;

  ResetPasswordBySMSParams(this.phoneNumber, this.smsCode, this.newPassword,this.screenCode);
}