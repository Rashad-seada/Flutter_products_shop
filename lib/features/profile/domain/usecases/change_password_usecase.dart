import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/profile/data/repo/profile_repo.dart';


class ChangePasswordUsecase implements Usecase<void,ChangePasswordParams> {
  ProfileRepo repo ;

  ChangePasswordUsecase({required this.repo});

  @override
  Future<Either<Failure, void>> call(ChangePasswordParams params) async {
    return await repo.changePassword(  oldPassword: params.oldPassword, newPassword: params.newPassword, screenCode: params.screenCode,);
  }
}

class ChangePasswordParams {
  int screenCode;
  String oldPassword;
  String newPassword;

  ChangePasswordParams(this.oldPassword,this.newPassword,this.screenCode);
}