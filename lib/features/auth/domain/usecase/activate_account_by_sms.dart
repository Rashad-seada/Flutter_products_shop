import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/auth/data/repo/auth_repo_impl.dart';
import 'package:eng_shop/features/auth/domain/entity/activate_phone_entity.dart';
import 'package:eng_shop/features/auth/domain/repo/auth_repo.dart';

class ActivateAccountBySmsUsecase implements Usecase<ActivatePhoneEntity,ActivateAccountBySmsParams> {
  AuthRepo repo = AuthRepoImpl();

  @override
  Future<Either<Failure, ActivatePhoneEntity>> call(ActivateAccountBySmsParams params) async {
    return await repo.activateAccountBySMS(params.mobile, params.pin, params.expectedPin);
  }
}

class ActivateAccountBySmsParams {
  String pin;
  String expectedPin;
  String mobile;

  ActivateAccountBySmsParams(this.pin, this.expectedPin, this.mobile);
}