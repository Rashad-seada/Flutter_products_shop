import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/profile/domain/repo/profile_repo.dart';

import '../entities/change_password_entity.dart';


class ChangePasswordUsecase implements Usecase<ChangePasswordEntity,ChangePasswordParams> {
  ProfileRepo repo ;

  ChangePasswordUsecase({required this.repo});

  @override
  Future<Either<Failure, ChangePasswordEntity>> call(ChangePasswordParams params) async {
    return await repo.changePassword(  oldPassword: params.oldPassword, newPassword: params.newPassword, screenCode: params.screenCode,);
  }
}

class ChangePasswordParams {
  int screenCode;
  String oldPassword;
  String newPassword;

  ChangePasswordParams(this.oldPassword,this.newPassword,this.screenCode);
}