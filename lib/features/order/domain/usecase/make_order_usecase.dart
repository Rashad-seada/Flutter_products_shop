import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';

import '../entities/make_order_entity.dart';
import '../repo/order_repo.dart';


class MakeOrderUsecase implements Usecase<MakeOrderEntity,MakeOrderParams> {
  OrderRepo repo ;

  MakeOrderUsecase({required this.repo});

  @override
  Future<Either<Failure, MakeOrderEntity>> call(MakeOrderParams params) async {
    return await repo.makeOrder(
        countryId: params.countryId,
        regionId: params.regionId,
        cityId: params.cityId,
        district: params.district,
        address: params.address,
        mobile: params.mobile,
        note: params.note,
        itemsCount: params.itemsCount,
        paidAmount: params.paidAmount,
        screenCode: params.screenCode
    );
  }
}

class MakeOrderParams {
  String countryId;
  String regionId;
  String cityId;
  String district;
  String address;
  String mobile;
  String note;
  int itemsCount;
  String paidAmount;
  int screenCode;

  MakeOrderParams(
      {required this.countryId,
        required this.regionId,
        required this.cityId,
        required this.district,
        required this.address,
        required this.mobile,
        required this.note,
        required this.itemsCount,
        required this.paidAmount,
        required this.screenCode,

      });
}