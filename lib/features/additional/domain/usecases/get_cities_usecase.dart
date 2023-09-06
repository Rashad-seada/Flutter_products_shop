import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/additional/domain/entities/get_cities_entity.dart';
import 'package:eng_shop/features/additional/domain/repo/additional_repo.dart';



class GetCitiesUsecase implements Usecase<List<GetCitiesEntity>,GetCitiesParams> {
  AdditionalRpo repo ;

  GetCitiesUsecase({required this.repo});

  @override
  Future<Either<Failure, List<GetCitiesEntity>>> call(GetCitiesParams params) async {
    return await repo.getCities(params.regionsId, params.screenCode);
  }
}

class GetCitiesParams {
  int screenCode;
  int regionsId;

  GetCitiesParams({required this.regionsId,required this.screenCode});
}