import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/auth/domain/entity/send_sms_entity.dart';
import 'package:eng_shop/features/auth/domain/repo/auth_repo.dart';


class SendSmsUsecase implements Usecase<SendSmsEntity,SendSmsParams> {
  AuthRepo repo ;

  SendSmsUsecase({required this.repo});

  @override
  Future<Either<Failure, SendSmsEntity>> call(SendSmsParams params) async {
    return await repo.sendSms(params.number,params.screenCode);
  }
}

class SendSmsParams {
  String number;
  int screenCode;

  SendSmsParams(this.number, this.screenCode);
}