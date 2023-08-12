import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/auth/data/repo/auth_repo_impl.dart';
import 'package:eng_shop/features/auth/domain/entity/validate_email_entity.dart';
import 'package:eng_shop/features/auth/domain/repo/auth_repo.dart';

class ValidateEmailUsecase implements Usecase<ValidateEmailEntity,ValidateEmailParams> {
  AuthRepo repo = AuthRepoImpl();

  @override
  Future<Either<Failure, ValidateEmailEntity>> call(ValidateEmailParams params) async {
    return await repo.validateEmail(params.email,params.screenCode);
  }
}

class ValidateEmailParams {
  String email;
  int screenCode;

  ValidateEmailParams(this.email, this.screenCode);
}