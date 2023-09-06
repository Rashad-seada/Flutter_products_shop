import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/additional/domain/entities/get_regions_entity.dart';
import 'package:eng_shop/features/additional/domain/repo/additional_repo.dart';



class GetRegionsUsecase implements Usecase<List<GetRegionsEntity>,GetRegionsParams> {
  AdditionalRpo repo ;

  GetRegionsUsecase({required this.repo});

  @override
  Future<Either<Failure, List<GetRegionsEntity>>> call(GetRegionsParams params) async {
    return await repo.getRegions(params.countryId,params.screenCode);
  }
}

class GetRegionsParams {
  int screenCode;
  int countryId;

  GetRegionsParams({required this.countryId,required this.screenCode});
}