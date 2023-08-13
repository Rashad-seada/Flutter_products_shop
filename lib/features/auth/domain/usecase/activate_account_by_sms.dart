import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/auth/domain/entity/activate_phone_entity.dart';
import 'package:eng_shop/features/auth/domain/repo/auth_repo.dart';

class ActivateAccountBySmsUsecase implements Usecase<ActivatePhoneEntity,ActivateAccountBySmsParams> {
  AuthRepo repo;

  ActivateAccountBySmsUsecase({required this.repo});

  @override
  Future<Either<Failure, ActivatePhoneEntity>> call(ActivateAccountBySmsParams params) async {
    return await repo.activateAccountBySMS(params.mobile, params.pin, params.expectedPin,params.screenCode);
  }
}

class ActivateAccountBySmsParams {
  String pin;
  String expectedPin;
  String mobile;
  int screenCode;

  ActivateAccountBySmsParams(this.pin, this.expectedPin, this.mobile,this.screenCode);
}