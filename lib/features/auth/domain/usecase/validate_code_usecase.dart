import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/auth/data/repo/auth_repo_impl.dart';
import 'package:eng_shop/features/auth/domain/entity/validate_code_entity.dart';
import 'package:eng_shop/features/auth/domain/repo/auth_repo.dart';

class ValidateCodeUsecase implements Usecase<ValidateCodeEntity,ValidateCodeParams> {
  AuthRepo repo = AuthRepoImpl();

  @override
  Future<Either<Failure, ValidateCodeEntity>> call(ValidateCodeParams params) async {
    return await repo.validateCode(params.phoneNumber,params.smsCode,params.screenCode);
  }
}

class ValidateCodeParams {
  String phoneNumber;
  String smsCode;
  int screenCode;

  ValidateCodeParams(this.phoneNumber, this.smsCode, this.screenCode);
}