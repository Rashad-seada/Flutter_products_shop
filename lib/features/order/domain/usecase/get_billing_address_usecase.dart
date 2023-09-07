import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/order/domain/entities/billing_address_entity.dart';
import 'package:eng_shop/features/order/domain/repo/order_repo.dart';




class GetBillingAddressUsecase implements Usecase<BillingAddressEntity?,GetBillingAddressParams> {
  OrderRepo repo ;

  GetBillingAddressUsecase({required this.repo});

  @override
  Future<Either<Failure, BillingAddressEntity?>> call(GetBillingAddressParams params) async {
    return await repo.getBillingAddress(screenCode: params.screenCode);
  }
}

class GetBillingAddressParams {
  int screenCode;


  GetBillingAddressParams(this.screenCode);
}