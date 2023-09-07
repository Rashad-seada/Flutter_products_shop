import 'package:eng_shop/features/order/domain/entities/billing_address_entity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

import '../../../../../core/config/app_consts.dart';
import '../../../../../core/error/exception.dart';

abstract class OrderLocalDataSource {

  Future<BillingAddressEntity?> getBillingAddress();
  Future<void> putBillingAddress(BillingAddressEntity billingAddressEntity);


}


class OrderLocalDataSourceImpl implements OrderLocalDataSource {

  Box storage;

  OrderLocalDataSourceImpl({required this.storage});

  String get billingAddressKey => AppConsts.billingAddressIdKey;


  @override
  Future<BillingAddressEntity?> getBillingAddress() async {
    try {
      return await storage.get(billingAddressKey);
    } catch (e) {
      print(e);
      throw LocalDataException();
    }
  }

  @override
  Future<void> putBillingAddress(BillingAddressEntity billingAddressEntity) async {
    try {
      await storage.put(billingAddressKey,billingAddressEntity);
    } catch (e) {
      print(e);
      throw LocalDataException();
    }
  }


}