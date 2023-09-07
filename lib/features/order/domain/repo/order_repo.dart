import 'package:dartz/dartz.dart';
import 'package:eng_shop/features/order/domain/entities/billing_address_entity.dart';

import '../../../../core/error/failure.dart';
import '../../../cart/domain/entity/cart_entity.dart';
import '../entities/make_order_entity.dart';
import '../entities/make_order_items_entity.dart';

abstract class OrderRepo {
  Future<Either<Failure, MakeOrderEntity>> makeOrder(
      {required String countryId,
      required String regionId,
      required String cityId,
      required String district,
      required String address,
      required String mobile,
      required String note,
      required int itemsCount,
      required String paidAmount,
      required int screenCode});

  Future<Either<Failure, MakeOrderItemsEntity>> makeOrderItems(
      {required String orderId,
      required String paidAmount,
      required List<CartEntity> products,
      required int screenCode});

  Future<Either<Failure, void>> putBillingAddress(
      {required BillingAddressEntity billingAddressEntity,
      required int screenCode});

  Future<Either<Failure, BillingAddressEntity?>> getBillingAddress(
      {required int screenCode});
}
