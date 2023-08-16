import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/auth/domain/repo/auth_repo.dart';


class LogoutUsecase implements Usecase<void,LogoutParams> {
  AuthRepo repo ;

  LogoutUsecase({required this.repo});

  @override
  Future<Either<Failure, void>> call(LogoutParams params) async {
    return await repo.logout(params.screenCode);
  }
}

class LogoutParams {
  int screenCode;
  LogoutParams(this.screenCode);

}