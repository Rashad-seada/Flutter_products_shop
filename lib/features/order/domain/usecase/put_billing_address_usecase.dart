import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/order/domain/entities/billing_address_entity.dart';
import 'package:eng_shop/features/order/domain/repo/order_repo.dart';




class PutBillingAddressUsecase implements Usecase<void,PutBillingAddressParams> {
  OrderRepo repo ;

  PutBillingAddressUsecase({required this.repo});

  @override
  Future<Either<Failure, void>> call(PutBillingAddressParams params) async {
    return await repo.putBillingAddress(screenCode: params.screenCode, billingAddressEntity: params.billingAddressEntity);
  }
}

class PutBillingAddressParams {
  int screenCode;
  BillingAddressEntity billingAddressEntity;

  PutBillingAddressParams({required this.billingAddressEntity,required this.screenCode});
}