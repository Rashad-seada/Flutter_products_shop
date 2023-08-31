import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/profile/domain/repo/profile_repo.dart';


class UpdateProfileUsecase implements Usecase<void,UpdateProfileParams> {
  ProfileRepo repo ;

  UpdateProfileUsecase({required this.repo});

  @override
  Future<Either<Failure, void>> call(UpdateProfileParams params) async {
    return await repo.updateProfile(screenCode: params.screenCode,name: params.name,email: params.email , mobile: params.mobile );
  }
}

class UpdateProfileParams {
  int screenCode;
  String? name;
  String? email;
  String? mobile;

  UpdateProfileParams({required this.screenCode,this.name,this.email,this.mobile});
}