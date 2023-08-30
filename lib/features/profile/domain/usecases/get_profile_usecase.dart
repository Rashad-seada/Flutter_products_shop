import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/profile/data/repo/profile_repo.dart';


class GetProfileUsecase implements Usecase<void,GetProfileParams> {
  ProfileRepo repo ;

  GetProfileUsecase({required this.repo});

  @override
  Future<Either<Failure, void>> call(GetProfileParams params) async {
    return await repo.getProfile(screenCode: params.screenCode,);
  }
}

class GetProfileParams {
  int screenCode;

  GetProfileParams(this.screenCode);
}