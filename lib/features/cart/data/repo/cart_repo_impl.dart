import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/infrastructure/api/api.dart';
import 'package:eng_shop/features/cart/data/data_source/local/cart_local_data_source.dart';
import 'package:eng_shop/features/cart/domain/repo/cart_repo.dart';

import '../../../../core/di/app_module.dart';
import '../../../../core/error/error_messages.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/infrastructure/services/services.dart';
import '../../../settings/data/data_source/local/settings_local_data_source.dart';
import '../../domain/entity/cart_entity.dart';
import '../../../shop/domain/entity/product_entity.dart';
import '../../../shop/data/data_source/remote/product_remote_data_source.dart';
import '../util/cart_response.dart';

class CartRepoImpl implements CartRepo {

  ProductRemoteDataSource remoteDataSource;
  CartLocalDataSource localDataSource;
  SettingsLocalDataSource settingsLocalDataSource;
  Services services;


  CartRepoImpl(
      {required this.remoteDataSource,
        required this.localDataSource,
        required this.settingsLocalDataSource,
        required this.services});

  initRemoteDataSource() async {
    try {
      remoteDataSource = ProductRemoteDataSourceImpl(
        domain: (await getIt<SettingsLocalDataSource>().getServiceProviderDomain())!,
        serviceEmail: (await getIt<SettingsLocalDataSource>().getServiceProviderEmail())!,
        servicePassword: (await getIt<SettingsLocalDataSource>().getServiceProviderPassword())!,
        client: getIt<Api>()
      );
    } catch (e) {
      throw LocalDataException();
    }
  }


  @override
  Future<Either<Failure, List<CartResponse>>> getCart(int screenCode) async {
    try {
      await initRemoteDataSource();

      if (await services.networkService.isConnected == false) {
        return left(ServiceFailure(ErrorMessages.network, screenCode: screenCode, customCode: 01));
      }

      List<CartEntity> cartEntity = await localDataSource.getCartProducts();

      if(cartEntity.isEmpty){
        return right([]);
      }


      List<ProductEntity> cartProducts = await remoteDataSource.getProductsById(cartEntity.map((e) => e.id!).toList());


      if(cartEntity.isEmpty) {
        return left(RemoteDataFailure(ErrorMessages.server, screenCode: screenCode, customCode: 02));
      }

      if(cartProducts[0].statusCode != 200) {
        return left(RemoteDataFailure(ErrorMessages.server, screenCode: screenCode, customCode: 00));
      }

      List<CartResponse> cartResponse = List.generate(cartEntity.length, (index) => CartResponse(cartEntity: cartEntity[index], productEntity: cartProducts[index]));

      return right(cartResponse);


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
  Future<Either<Failure, void>> addToCart(ProductEntity productEntity, int screenCode) async {
    try {

      await localDataSource.insertCartProduct(productEntity);

      return right(Unit);

    } on LocalDataException {
      return left(LocalDataFailure(ErrorMessages.cachingFailure, screenCode: screenCode, customCode: 00));

    } catch (e) {
      return left(InternalFailure(e.toString(), screenCode: screenCode, customCode: 00));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromCart(ProductEntity productEntity,int screenCode) async {
    try {

      await localDataSource.deleteCartProduct(productEntity);

      return right(Unit);

    } on LocalDataException {
      return left(LocalDataFailure(ErrorMessages.cachingFailure, screenCode: screenCode, customCode: 00));
    } catch (e) {
      return left(InternalFailure(e.toString(), screenCode: screenCode, customCode: 00));
    }
  }

  @override
  Future<Either<Failure, void>> updateCartProduct(CartEntity productEntity, int screenCode) async {
    try {
      print(productEntity.quantity);

      localDataSource.updateCartProduct(productEntity);
      return right(Unit);

    } on LocalDataException {

      return left(LocalDataFailure(ErrorMessages.cachingFailure, screenCode: screenCode, customCode: 00));
    } catch (e) {
      return left(InternalFailure(e.toString(), screenCode: screenCode, customCode: 00));
    }
  }

}