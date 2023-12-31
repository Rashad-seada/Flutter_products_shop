import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/auth/domain/entity/registration_entity.dart';
import 'package:eng_shop/features/auth/domain/repo/auth_repo.dart';

class RegisterUsecase implements Usecase<RegistrationEntity,RegistrationParams> {
  AuthRepo repo;

  RegisterUsecase({required this.repo});

  @override
  Future<Either<Failure, RegistrationEntity>> call(RegistrationParams params) async {
    return await repo.register(params.userName, params.email, params.upass, params.mobile,params.screenCode);
  }
}

class RegistrationParams {
  String userName;
  String email;
  String upass;
  String mobile;
  int screenCode;

  RegistrationParams(
      this.userName, this.email, this.upass, this.mobile, this.screenCode);
}