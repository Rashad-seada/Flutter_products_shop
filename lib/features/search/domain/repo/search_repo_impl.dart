
import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/infrastructure/api/api.dart';
import 'package:eng_shop/features/auth/data/data_source/local_data_source/auth_local_data_source.dart';
import 'package:eng_shop/features/search/data/data_source/local_data_source/search_local_data_source.dart';
import 'package:eng_shop/features/search/domain/entity/recent_search_entity.dart';

import '../../../../core/di/app_module.dart';
import '../../../../core/error/error_messages.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/infrastructure/services/services.dart';
import '../../../settings/data/data_source/local/settings_local_data_source.dart';
import '../../../shop/domain/entity/product_entity.dart';
import '../../data/data_source/remote_data_source/search_remote_data_source.dart';
import '../../data/repo/search_repo.dart';

class SearchRepoImpl implements SearchRepo {

  SearchRemoteDataSource remoteDataSource;
  SearchLocalDataSource localDataSource;
  SettingsLocalDataSource settingsLocalDataSource;
  Services services;


  SearchRepoImpl(
      {required this.remoteDataSource,
        required this.localDataSource,
        required this.settingsLocalDataSource,
        required this.services});

  initRemoteDataSource() async {
    try {
      remoteDataSource = SearchRemoteDataSourceImpl(
        domain: (await getIt<SettingsLocalDataSource>().getServiceProviderDomain())!,
        serviceEmail: (await getIt<AuthLocalDataSource>().getEmail())!,
        servicePassword: (await getIt<AuthLocalDataSource>().getPassword())!,
        client: getIt<Api>(),
        userId: (await getIt<AuthLocalDataSource>().getUserID())!,
      );
    } catch (e) {
      throw LocalDataException();
    }
  }


  @override
  Future<Either<Failure, List<ProductEntity>>> searchProduct(String searchTerm, int screenCode) async {
    try {
      await initRemoteDataSource();

      if (await services.networkService.isConnected == false) {
        return left(ServiceFailure(ErrorMessages.network, screenCode: screenCode, customCode: 01));
      }

      List<ProductEntity> productEntity = await remoteDataSource.searchProducts(searchTerm);



      return right(productEntity);


    } on RemoteDataException {
      return left(RemoteDataFailure(ErrorMessages.serverDown, screenCode: screenCode, customCode: 00));
    } on LocalDataException {
      return left(LocalDataFailure(ErrorMessages.cachingFailure, screenCode: screenCode, customCode: 00));
    } on ServiceException {
      return left(ServiceFailure(ErrorMessages.serviceProvider, screenCode: screenCode, customCode: 00));
    } catch (e) {
      return left(InternalFailure(e.toString(), screenCode: screenCode, customCode: 00));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAllRecentSearch(int screenCode) async {
    try {

      await localDataSource.clearAllRecentSearch();
      return right(Unit);


    } on LocalDataException {
      return left(LocalDataFailure(ErrorMessages.cachingFailure, screenCode: screenCode, customCode: 00));
    } catch (e) {
      return left(InternalFailure(e.toString(), screenCode: screenCode, customCode: 00));
    }
  }

  @override
  Future<Either<Failure, void>> deleteRecentSearch(RecentSearchEntity recentSearchEntity, int screenCode) async {
    try {

      await localDataSource.deleteRecentSearch(recentSearchEntity);
      return right(Unit);


    } on LocalDataException {
      return left(LocalDataFailure(ErrorMessages.cachingFailure, screenCode: screenCode, customCode: 00));
    } catch (e) {
      return left(InternalFailure(e.toString(), screenCode: screenCode, customCode: 00));
    }
  }

  @override
  Future<Either<Failure, List<RecentSearchEntity>>> getRecentSearch(int screenCode) async {
    try {

      List<RecentSearchEntity> recentSearchEntites = await localDataSource.getRecentSearch();

      return right(recentSearchEntites);


    } on LocalDataException {
      return left(LocalDataFailure(ErrorMessages.cachingFailure, screenCode: screenCode, customCode: 00));
    } catch (e) {
      return left(InternalFailure(e.toString(), screenCode: screenCode, customCode: 00));
    }
  }

  @override
  Future<Either<Failure, void>> insertRecentSearch(RecentSearchEntity recentSearchEntity, int screenCode) async {
    try {

      await localDataSource.insertRecentSearch(recentSearchEntity);

      return right(Unit);


    } on LocalDataException {
      return left(LocalDataFailure(ErrorMessages.cachingFailure, screenCode: screenCode, customCode: 00));
    } catch (e) {
      return left(InternalFailure(e.toString(), screenCode: screenCode, customCode: 00));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getSuggestedProducts(String searchTerm, int screenCode) async {
    try {
      await initRemoteDataSource();

      if (await services.networkService.isConnected == false) {
        return left(ServiceFailure(ErrorMessages.network, screenCode: screenCode, customCode: 01));
      }

      List<ProductEntity> productEntity = await remoteDataSource.searchProducts(searchTerm);


      return right(productEntity);


    } on RemoteDataException {
      return left(RemoteDataFailure(ErrorMessages.serverDown, screenCode: screenCode, customCode: 00));
    } on LocalDataException {
      return left(LocalDataFailure(ErrorMessages.cachingFailure, screenCode: screenCode, customCode: 00));
    } on ServiceException {
      return left(ServiceFailure(ErrorMessages.serviceProvider, screenCode: screenCode, customCode: 00));
    } catch (e) {
      return left(InternalFailure(e.toString(), screenCode: screenCode, customCode: 00));
    }
  }




}