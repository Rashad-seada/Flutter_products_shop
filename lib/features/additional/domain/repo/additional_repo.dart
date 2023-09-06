import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';

import '../entities/get_cities_entity.dart';
import '../entities/get_countries_entity.dart';
import '../entities/get_regions_entity.dart';

abstract class AdditionalRpo {

  Future<Either<Failure,List<GetCountriesEntity>>> getCountries(int screenCode);

  Future<Either<Failure,List<GetRegionsEntity>>> getRegions(int countryId,int screenCode);

  Future<Either<Failure,List<GetCitiesEntity>>> getCities(int regionsId,int screenCode);

}