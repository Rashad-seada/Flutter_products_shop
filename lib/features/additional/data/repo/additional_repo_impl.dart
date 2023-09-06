import 'package:dartz/dartz.dart';

import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/features/additional/data/data_source/remote/additional_remote_data_source.dart';

import 'package:eng_shop/features/additional/domain/entities/get_cities_entity.dart';

import 'package:eng_shop/features/additional/domain/entities/get_countries_entity.dart';

import 'package:eng_shop/features/additional/domain/entities/get_regions_entity.dart';

import '../../../../core/di/app_module.dart';
import '../../../../core/error/error_messages.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/infrastructure/api/api.dart';
import '../../../../core/infrastructure/services/services.dart';
import '../../../auth/data/data_source/local_data_source/auth_local_data_source.dart';
import '../../../settings/data/data_source/local/settings_local_data_source.dart';
import '../../domain/repo/additional_repo.dart';

class AdditionalRpoImpl implements AdditionalRpo {

  AdditionalRemoteDataSource remoteDataSource;
  AuthLocalDataSource authLocalDataSource;
  Services services;


  AdditionalRpoImpl(
      {required this.remoteDataSource,
        required this.authLocalDataSource,
        required this.services});


  initRemoteDataSource() async {
    try {
      remoteDataSource = AdditionalRemoteDataSourceImpl(
        domain: (await getIt<SettingsLocalDataSource>().getServiceProviderDomain())!,
        client: getIt<Api>(),
        userID: (await getIt<AuthLocalDataSource>().getUserID())!,
        serviceEmail: (await getIt<AuthLocalDataSource>().getEmail())!,
        servicePassword: (await getIt<AuthLocalDataSource>().getPassword())!,
      );
    } catch (e) {
      throw LocalDataException();
    }
  }


  @override
  Future<Either<Failure, List<GetCitiesEntity>>> getCities(int regionsId,int screenCode) async {
    try {
      await initRemoteDataSource();

      if (await services.networkService.isConnected == false) {
        return left(ServiceFailure(ErrorMessages.network, screenCode: screenCode, customCode: 01));
      }

      List<GetCitiesEntity> cities = await remoteDataSource.getCities(regionsId);


      return right(cities);


    } on RemoteDataException {
      return left(RemoteDataFailure(ErrorMessages.serverDown, screenCode: screenCode, customCode: 00));
    } on ServiceException {
      return left(ServiceFailure(ErrorMessages.serviceProvider, screenCode: screenCode, customCode: 00));
    } catch (e) {
      return left(InternalFailure(e.toString(), screenCode: screenCode, customCode: 00));
    }
  }

  @override
  Future<Either<Failure, List<GetCountriesEntity>>> getCountries(int screenCode) async {
    try {
      await initRemoteDataSource();

      if (await services.networkService.isConnected == false) {
        return left(ServiceFailure(ErrorMessages.network, screenCode: screenCode, customCode: 01));
      }

      List<GetCountriesEntity> countries = await remoteDataSource.getCountries();


      return right(countries);


    } on RemoteDataException {
      return left(RemoteDataFailure(ErrorMessages.serverDown, screenCode: screenCode, customCode: 00));
    } on ServiceException {
      return left(ServiceFailure(ErrorMessages.serviceProvider, screenCode: screenCode, customCode: 00));
    } catch (e) {
      return left(InternalFailure(e.toString(), screenCode: screenCode, customCode: 00));
    }
  }

  @override
  Future<Either<Failure, List<GetRegionsEntity>>> getRegions(int countryId,int screenCode) async {
    try {
      await initRemoteDataSource();

      if (await services.networkService.isConnected == false) {
        return left(ServiceFailure(ErrorMessages.network, screenCode: screenCode, customCode: 01));
      }

      List<GetRegionsEntity> regions = await remoteDataSource.getRegions(countryId);


      return right(regions);


    } on RemoteDataException {
      return left(RemoteDataFailure(ErrorMessages.serverDown, screenCode: screenCode, customCode: 00));
    } on ServiceException {
      return left(ServiceFailure(ErrorMessages.serviceProvider, screenCode: screenCode, customCode: 00));
    } catch (e) {
      return left(InternalFailure(e.toString(), screenCode: screenCode, customCode: 00));
    }
  }



}