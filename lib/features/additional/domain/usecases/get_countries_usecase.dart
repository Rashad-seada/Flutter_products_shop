import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/additional/domain/entities/get_countries_entity.dart';
import 'package:eng_shop/features/additional/domain/repo/additional_repo.dart';



class GetCountriesUsecase implements Usecase<List<GetCountriesEntity>,GetCountriesParams> {
  AdditionalRpo repo ;

  GetCountriesUsecase({required this.repo});

  @override
  Future<Either<Failure, List<GetCountriesEntity>>> call(GetCountriesParams params) async {
    return await repo.getCountries(params.screenCode);
  }
}

class GetCountriesParams {
  int screenCode;

  GetCountriesParams({required this.screenCode});
}