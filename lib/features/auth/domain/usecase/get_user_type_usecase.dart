import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/auth/domain/repo/auth_repo.dart';
import 'package:eng_shop/features/auth/domain/util/user_type_enum.dart';


class GetUserTypeUsecase implements Usecase<UserType?,GetUserTypeParams> {
  AuthRepo repo ;

  GetUserTypeUsecase({required this.repo});

  @override
  Future<Either<Failure, UserType?>> call(GetUserTypeParams params) async {
    return await repo.getUserType(params.screenCode);
  }
}

class GetUserTypeParams {
  int screenCode;
  GetUserTypeParams(this.screenCode);
}