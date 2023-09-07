import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/features/cart/domain/entity/cart_entity.dart';
import 'package:eng_shop/features/order/data/data_source/local/order_local_data_source.dart';
import 'package:eng_shop/features/order/domain/entities/billing_address_entity.dart';

import '../../../../core/di/app_module.dart';
import '../../../../core/error/error_messages.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/infrastructure/api/api.dart';
import '../../../../core/infrastructure/services/services.dart';
import '../../../auth/data/data_source/local_data_source/auth_local_data_source.dart';
import '../../../settings/data/data_source/local/settings_local_data_source.dart';
import '../../domain/entities/make_order_entity.dart';
import '../../domain/entities/make_order_items_entity.dart';
import '../../domain/repo/order_repo.dart';
import '../data_source/remote/order_remote_data_source.dart';

class OrderRepoImpl implements OrderRepo {

  OrderRemoteDataSource remoteDataSource;
  OrderLocalDataSource localDataSource;
  AuthLocalDataSource authLocalDataSource;
  Services services;


  OrderRepoImpl(
      {required this.remoteDataSource,
        required this.localDataSource,
        required this.authLocalDataSource,
        required this.services});


  initRemoteDataSource() async {
    try {
      remoteDataSource = OrderRemoteDataSourceImpl(
        domain: (await getIt<SettingsLocalDataSource>().getServiceProviderDomain())!,
        client: getIt<Api>(),
        serviceEmail: (await getIt<AuthLocalDataSource>().getEmail())!,
        servicePassword: (await getIt<AuthLocalDataSource>().getPassword())!,
        userId: (await getIt<AuthLocalDataSource>().getUserID())!,
      );
    } catch (e) {
      throw LocalDataException();
    }
  }


  @override
  Future<Either<Failure, MakeOrderEntity>> makeOrder({
    required String countryId,
    required String regionId,
    required String cityId,
    required String district,
    required String address,
    required String mobile,
    required String note,
    required int itemsCount,
    required String paidAmount,
    required int screenCode,

  }) async {
    try {
      await initRemoteDataSource();

      if (await services.networkService.isConnected == false) {
        return left(ServiceFailure(ErrorMessages.network, screenCode: screenCode, customCode: 01));
      }

      MakeOrderEntity makeOrderEntity = await remoteDataSource.makeOrder(
          countryId: countryId,
          regionId: regionId,
          cityId: cityId,
          district: district,
          address: address,
          mobile: mobile,
          note: note,
          itemsCount: itemsCount,
          paidAmount: paidAmount,
          paidMethodId: ""
      );

    if(int.parse("${makeOrderEntity.res}") < 1) {
      return left(RemoteDataFailure(ErrorMessages.server, screenCode: screenCode, customCode: 02));
    }

    if(makeOrderEntity.statusCode != 200) {
      return left(RemoteDataFailure(ErrorMessages.server, screenCode: screenCode, customCode: 00));
    }

    return right(makeOrderEntity);


    } on RemoteDataException {
    return left(RemoteDataFailure(ErrorMessages.serverDown, screenCode: screenCode, customCode: 00));
    } on ServiceException {
    return left(ServiceFailure(ErrorMessages.serviceProvider, screenCode: screenCode, customCode: 00));
    } catch (e) {
    return left(InternalFailure(e.toString(), screenCode: screenCode, customCode: 00));
    }
  }

  @override
  Future<Either<Failure, MakeOrderItemsEntity>> makeOrderItems({
    required String orderId,
    required String paidAmount,
    required List<CartEntity> products,
    required int screenCode,

  }) async {
    try {
      await initRemoteDataSource();

      if (await services.networkService.isConnected == false) {
        return left(ServiceFailure(ErrorMessages.network, screenCode: screenCode, customCode: 01));
      }

      MakeOrderItemsEntity makeOrderItemsEntity = await remoteDataSource.makeOrderItems(
          orderId: orderId,
          paidAmount: paidAmount,
          products: products
      );

      if(int.parse("${makeOrderItemsEntity.res}") < 1) {
        return left(RemoteDataFailure(ErrorMessages.server, screenCode: screenCode, customCode: 02));
      }

      if(makeOrderItemsEntity.statusCode != 200) {
        return left(RemoteDataFailure(ErrorMessages.server, screenCode: screenCode, customCode: 00));
      }

      return right(makeOrderItemsEntity);


    } on RemoteDataException {
      return left(RemoteDataFailure(ErrorMessages.serverDown, screenCode: screenCode, customCode: 00));
    } on ServiceException {
      return left(ServiceFailure(ErrorMessages.serviceProvider, screenCode: screenCode, customCode: 00));
    } catch (e) {
      return left(InternalFailure(e.toString(), screenCode: screenCode, customCode: 00));
    }
  }

  @override
  Future<Either<Failure, BillingAddressEntity?>> getBillingAddress({required int screenCode}) async {
    try {


      BillingAddressEntity? billingAddressEntity = await localDataSource.getBillingAddress();


      return right(billingAddressEntity);


    } on LocalDataException {
      return left(LocalDataFailure(ErrorMessages.cachingFailure, screenCode: screenCode, customCode: 00));
    } catch (e) {
      return left(InternalFailure(e.toString(), screenCode: screenCode, customCode: 00));
    }
  }

  @override
  Future<Either<Failure, void>> putBillingAddress({required BillingAddressEntity billingAddressEntity, required int screenCode}) async {
    try {


      await localDataSource.putBillingAddress(billingAddressEntity,);


      return right(Unit);


    } on LocalDataException {
      return left(LocalDataFailure(ErrorMessages.cachingFailure, screenCode: screenCode, customCode: 00));
    } catch (e) {
      return left(InternalFailure(e.toString(), screenCode: screenCode, customCode: 00));
    }
  }
}