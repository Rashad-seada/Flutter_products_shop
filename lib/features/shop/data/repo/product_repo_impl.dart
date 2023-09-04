import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/infrastructure/api/api.dart';
import 'package:eng_shop/features/auth/data/data_source/local_data_source/auth_local_data_source.dart';

import '../../../../core/di/app_module.dart';
import '../../../../core/error/error_messages.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/infrastructure/services/services.dart';
import '../../domain/entity/product_entity.dart';
import '../../domain/repo/product_repo.dart';
import '../data_source/local/product_local_data_source.dart';
import '../../../settings/data/data_source/local/settings_local_data_source.dart';
import '../data_source/remote/product_remote_data_source.dart';

class ProductRepoImpl implements ProductRepo {

  ProductRemoteDataSource remoteDataSource;
  ProductLocalDataSource localDataSource;
  SettingsLocalDataSource settingsLocalDataSource;
  Services services;


  ProductRepoImpl(
      {required this.remoteDataSource,
        required this.localDataSource,
        required this.settingsLocalDataSource,
        required this.services});

  initRemoteDataSource() async {
    try {
      remoteDataSource = ProductRemoteDataSourceImpl(
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
  Future<Either<Failure, List<ProductEntity>>> getProductById(int id,int screenCode) async {
    try {
      await initRemoteDataSource();

      if (await services.networkService.isConnected == false) {
        return left(ServiceFailure(ErrorMessages.network, screenCode: screenCode, customCode: 01));
      }

      List<ProductEntity> productEntity = await remoteDataSource.getProductById(id);

      if(productEntity.isEmpty) {
        return left(RemoteDataFailure(ErrorMessages.server, screenCode: screenCode, customCode: 02));
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

    }catch (e) {
      return left(InternalFailure(e.toString(), screenCode: screenCode, customCode: 00));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsById(List<int> ids,int screenCode) async {
    try {
      await initRemoteDataSource();


      if (await services.networkService.isConnected == false) {
        return left(ServiceFailure(ErrorMessages.network, screenCode: screenCode, customCode: 01));
      }

      List<ProductEntity> productEntity = await remoteDataSource.getProductsById(ids);

      if(productEntity.isEmpty) {
        return left(RemoteDataFailure(ErrorMessages.server, screenCode: screenCode, customCode: 02));
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

    }catch (e) {
      return left(InternalFailure(e.toString(), screenCode: screenCode, customCode: 00));
    }
  }

  @override
  Future<Either<Failure, String>> getProductImageById(int id, int screenCode) async {
    try {
      await initRemoteDataSource();

      String image = remoteDataSource.getProductImageById(id);

      return right(image);

    } on LocalDataException {
      return left(LocalDataFailure(ErrorMessages.cachingFailure, screenCode: screenCode, customCode: 00));

    } catch (e) {
      return left(InternalFailure(e.toString(), screenCode: screenCode, customCode: 00));
    }
  }



  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts(int pageNumber,int screenCode) async {
    try {
      await initRemoteDataSource();

      if (await services.networkService.isConnected == false) {
        List<ProductEntity> productEntity = await localDataSource.getProducts();

        if(productEntity.isEmpty){
          return left(ServiceFailure(ErrorMessages.network, screenCode: screenCode, customCode: 01));
        }

        return right(productEntity);
      }


      List<ProductEntity> productEntity = await remoteDataSource.getProducts(pageNumber);

      if(productEntity.isEmpty) {
        return left(RemoteDataFailure(ErrorMessages.emptyListOfProducts, screenCode: screenCode, customCode: 03));
      }

      if(productEntity[0].statusCode != 200) {
        return left(RemoteDataFailure(ErrorMessages.server, screenCode: screenCode, customCode: 00));
      }

      await localDataSource.insertAllProduct(productEntity);

      List<ProductEntity> allProducts = await localDataSource.getProducts();
      return right(allProducts);


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
  Future<Either<Failure, void>> dropAllProducts(int screenCode) async {
    try {

      await localDataSource.dropAllProducts();
      return right(Unit);

    } on LocalDataException {

      return left(LocalDataFailure(ErrorMessages.cachingFailure, screenCode: screenCode, customCode: 00));
    } catch (e) {
      return left(InternalFailure(e.toString(), screenCode: screenCode, customCode: 00));
    }
  }



}