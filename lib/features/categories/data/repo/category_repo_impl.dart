import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/features/auth/data/data_source/local_data_source/auth_local_data_source.dart';
import 'package:eng_shop/features/categories/domain/entities/category_entity.dart';
import 'package:eng_shop/features/shop/domain/entity/product_entity.dart';
import 'package:eng_shop/features/categories/domain/repo/category_repo.dart';

import '../../../../core/di/app_module.dart';
import '../../../../core/error/error_messages.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/infrastructure/api/api.dart';
import '../../../../core/infrastructure/services/services.dart';
import '../data_source/remote/category_remote_data_source.dart';
import '../../../settings/data/data_source/local/settings_local_data_source.dart';

class CategoryRepoImpl implements CategoryRepo {

  CategoryRemoteDataSource categoryRemoteDataSource ;
  Services services;

  CategoryRepoImpl(
      {required this.categoryRemoteDataSource,
        required this.services});

  initRemoteDataSource() async {
    try {
      categoryRemoteDataSource = CategoryRemoteDataSourceImpl(
        domain: (await getIt<SettingsLocalDataSource>().getServiceProviderDomain())!,
        serviceEmail: (await getIt<AuthLocalDataSource>().getEmail())!,
        servicePassword: (await getIt<AuthLocalDataSource>().getPassword())!,
        client: getIt<Api>(),
      );
    } catch (e) {
      throw LocalDataException();
    }
  }
  
  @override
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories(int screenCode) async  {
    try {
    await initRemoteDataSource();

    if (await services.networkService.isConnected == false) {
      return left(ServiceFailure(ErrorMessages.network, screenCode: screenCode, customCode: 01));
    }


    List<CategoryEntity> categories = await categoryRemoteDataSource.getCategories();

    if(categories.isEmpty || categories[0].statusCode != 200) {
    return left(RemoteDataFailure(ErrorMessages.server, screenCode: screenCode, customCode: 00));
    }


    return right(categories);


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
  Future<Either<Failure, List<ProductEntity>>> getCategoryProducts(int pageNumber,CategoryEntity categoryEntity, int screenCode) async {
    try {
      await initRemoteDataSource();

      if (await services.networkService.isConnected == false) {
        return left(ServiceFailure(ErrorMessages.network, screenCode: screenCode, customCode: 01));
      }


      List<ProductEntity> products = await categoryRemoteDataSource.getCategoryProducts(pageNumber,categoryEntity);

      if(products.isNotEmpty){
        if(products[0].statusCode != 200) {
          return left(RemoteDataFailure(ErrorMessages.server, screenCode: screenCode, customCode: 00));
        }
      }


      return right(products);


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
  Future<Either<Failure, List<CategoryEntity>>> getSubCategoriesById(int parentCategoryId, int screenCode) async {
    try {
      await initRemoteDataSource();

      if (await services.networkService.isConnected == false) {
        return left(ServiceFailure(ErrorMessages.network, screenCode: screenCode, customCode: 01));
      }


      List<CategoryEntity> categories = await categoryRemoteDataSource.getSubCategoriesById(parentCategoryId);

      if(categories.isNotEmpty){
        if(categories[0].statusCode != 200) {
          return left(RemoteDataFailure(ErrorMessages.server, screenCode: screenCode, customCode: 00));
        }
      }

      return right(categories);

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