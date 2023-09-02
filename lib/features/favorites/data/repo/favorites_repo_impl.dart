import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/features/favorites/data/data_source/remote/favorite_remote_data_source.dart';
import 'package:eng_shop/features/favorites/domain/entities/add_favorite_entity.dart';
import 'package:eng_shop/features/favorites/domain/repo/favorites_repo.dart';
import 'package:eng_shop/features/favorites/domain/entities/product_favorite_entity.dart';
import 'package:eng_shop/features/shop/domain/entity/product_entity.dart';

import '../../../../core/di/app_module.dart';
import '../../../../core/error/error_messages.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/infrastructure/api/api.dart';
import '../../../../core/infrastructure/services/services.dart';
import '../../../auth/data/data_source/local_data_source/auth_local_data_source.dart';
import '../../../profile/data/data_source/remote/profile_remote_data_source.dart';
import '../../../settings/data/data_source/local/settings_local_data_source.dart';

class FavoriteRepoImpl implements FavoriteRepo {


  FavoriteRemoteDataSource remoteDataSource;
  AuthLocalDataSource authLocalDataSource;
  Services services;


  FavoriteRepoImpl(
      {required this.remoteDataSource,
        required this.authLocalDataSource,
        required this.services});


  initRemoteDataSource() async {
    try {
      remoteDataSource = FavoriteRemoteDataSourceImpl(
          domain: (await getIt<SettingsLocalDataSource>().getServiceProviderDomain())!,
          client: getIt<Api>()
      );
    } catch (e) {
      throw LocalDataException();
    }
  }

  @override
  Future<Either<Failure, AddFavoriteEntity>> addToFavorite({required int productId,required int screenCode}) async {
    try {
      await initRemoteDataSource();

      if (await services.networkService.isConnected == false) {
        return left(ServiceFailure(ErrorMessages.network, screenCode: screenCode, customCode: 01));
      }

      AddFavoriteEntity addFavoriteEntity = await remoteDataSource.addToFavorite(
          email: (await authLocalDataSource.getEmail())!,
          password: (await authLocalDataSource.getPassword())!,
          userId: (await authLocalDataSource.getUserID())!,
          productId: productId
      );

    if(addFavoriteEntity.res != "1") {
    return left(RemoteDataFailure(ErrorMessages.server, screenCode: screenCode, customCode: 02));
    }

    if(addFavoriteEntity.statusCode != 200) {
    return left(RemoteDataFailure(ErrorMessages.server, screenCode: screenCode, customCode: 00));
    }

    return right(addFavoriteEntity);


    } on RemoteDataException {
    return left(RemoteDataFailure(ErrorMessages.serverDown, screenCode: screenCode, customCode: 00));
    } on ServiceException {
    return left(ServiceFailure(ErrorMessages.serviceProvider, screenCode: screenCode, customCode: 00));
    } catch (e) {
    return left(InternalFailure(e.toString(), screenCode: screenCode, customCode: 00));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getUserFavorite({required int screenCode}) async  {
    try {
      await initRemoteDataSource();

      if (await services.networkService.isConnected == false) {
        return left(ServiceFailure(ErrorMessages.network, screenCode: screenCode, customCode: 01));
      }

      List<ProductEntity> favoriteProducts = await remoteDataSource.getUserFavorite(
        email: (await authLocalDataSource.getEmail())!,
        password: (await authLocalDataSource.getPassword())!,
        userId: (await authLocalDataSource.getUserID())!,
      );

      return right(favoriteProducts);


    } on RemoteDataException {
      return left(RemoteDataFailure(ErrorMessages.serverDown, screenCode: screenCode, customCode: 00));
    } on ServiceException {
      return left(ServiceFailure(ErrorMessages.serviceProvider, screenCode: screenCode, customCode: 00));
    } catch (e) {
      return left(InternalFailure(e.toString(), screenCode: screenCode, customCode: 00));
    }
  }

  @override
  Future<Either<Failure, AddFavoriteEntity>> removeFromFavorite({required int productId,required int screenCode}) async {
    try {
      await initRemoteDataSource();

      if (await services.networkService.isConnected == false) {
        return left(ServiceFailure(ErrorMessages.network, screenCode: screenCode, customCode: 01));
      }

      AddFavoriteEntity addFavoriteEntity = await remoteDataSource.addToFavorite(
          email: (await authLocalDataSource.getEmail())!,
          password: (await authLocalDataSource.getPassword())!,
          userId: (await authLocalDataSource.getUserID())!,
          productId: productId
      );

      if(addFavoriteEntity.res != "1") {
        return left(RemoteDataFailure(ErrorMessages.server, screenCode: screenCode, customCode: 02));
      }

      return right(addFavoriteEntity);


    } on RemoteDataException {
      return left(RemoteDataFailure(ErrorMessages.serverDown, screenCode: screenCode, customCode: 00));
    } on ServiceException {
      return left(ServiceFailure(ErrorMessages.serviceProvider, screenCode: screenCode, customCode: 00));
    } catch (e) {
      return left(InternalFailure(e.toString(), screenCode: screenCode, customCode: 00));
    }
  }






}