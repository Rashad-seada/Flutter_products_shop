import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/auth/data/repo/auth_repo_impl.dart';
import 'package:eng_shop/features/auth/domain/entity/send_sms_entity.dart';
import 'package:eng_shop/features/auth/domain/repo/auth_repo.dart';


class SendSmsUsecase implements Usecase<SendSmsEntity,SendSmsParams> {
  AuthRepo repo = AuthRepoImpl();

  @override
  Future<Either<Failure, SendSmsEntity>> call(SendSmsParams params) async {
    return await repo.sendSms(params.number,);
  }
}

class SendSmsParams {
  String number;

  SendSmsParams(this.number);
}