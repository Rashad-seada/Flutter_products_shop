import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';


import '../../../cart/domain/entity/cart_entity.dart';
import '../../../cart/domain/usecase/clear_cart_usecase.dart';
import '../entities/make_order_items_entity.dart';
import '../repo/order_repo.dart';


class MakeOrderItemsUsecase implements Usecase<MakeOrderItemsEntity,MakeOrderItemsParams> {
  OrderRepo repo ;
  ClearCartUsecase clearCartUsecase;

  MakeOrderItemsUsecase({required this.repo,required this.clearCartUsecase});

  @override
  Future<Either<Failure, MakeOrderItemsEntity>> call(MakeOrderItemsParams params) async {



    return await repo.makeOrderItems(
        orderId: params.orderId,
        paidAmount: params.paidAmount,
        products: params.products,
        screenCode: params.screenCode
    ).then((value) => value.fold(
            (error) {
              return left(error);
            },
            (makeOrderSuccess) {
              return clearCartUsecase.call(ClearCartParams(params.screenCode)).then(
                      (value) => value.fold(
                              (error) {
                                return left(error);
                              },
                              (success) {
                                return right(makeOrderSuccess);

                              }
                      )
              );
            }
    ));
  }
}

class MakeOrderItemsParams {
  String orderId;
  String paidAmount;
  List<CartEntity> products;
  int screenCode;

  MakeOrderItemsParams({
    required this.orderId,
    required this.paidAmount,
    required this.products,
    required this.screenCode
  });

}