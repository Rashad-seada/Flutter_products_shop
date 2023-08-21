
import 'package:dartz/dartz.dart';
import 'package:eng_shop/features/search/data/data_source/local_data_source/search_local_data_source.dart';

import '../../../../core/di/app_module.dart';
import '../../../../core/error/error_messages.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/services/services.dart';
import '../../../shop/data/data_source/local_data_source/settings_local_data_source.dart';
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
        serviceEmail: (await getIt<SettingsLocalDataSource>().getServiceProviderEmail())!,
        servicePassword: (await getIt<SettingsLocalDataSource>().getServiceProviderPassword())!,
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

      if(productEntity.isEmpty) {
        return left(RemoteDataFailure(ErrorMessages.emptyListOfProductsInSearch, screenCode: screenCode, customCode: 03));
      }

      if(productEntity[0].statusCode != 200) {
        return left(RemoteDataFailure(ErrorMessages.server, screenCode: screenCode, customCode: 00));
      }


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