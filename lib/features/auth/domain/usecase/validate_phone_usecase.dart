import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/auth/data/repo/auth_repo_impl.dart';
import 'package:eng_shop/features/auth/domain/repo/auth_repo.dart';

import '../entity/validate_phone_entity.dart';

class ValidatePhoneUsecase implements Usecase<ValidatePhoneEntity,ValidatePhoneParams> {
  AuthRepo repo = AuthRepoImpl();

  @override
  Future<Either<Failure, ValidatePhoneEntity>> call(ValidatePhoneParams params) async {
    return await repo.validatePhone(params.phoneNumber,params.screenCode);
  }
}

class ValidatePhoneParams {
  String phoneNumber;
  int screenCode;

  ValidatePhoneParams(this.phoneNumber, this.screenCode);
}