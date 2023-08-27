import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';

import '../../../shop/domain/entity/product_entity.dart';
import '../repo/cart_repo.dart';




class RemoveFromCartUsecase implements Usecase<void,RemoveFromCartParams> {
  CartRepo repo ;

  RemoveFromCartUsecase({required this.repo});

  @override
  Future<Either<Failure, void>> call(RemoveFromCartParams params) async {
    return await repo.removeFromCart(params.productEntity, params.screenCode);
  }
}

class RemoveFromCartParams {
  ProductEntity productEntity;
  int screenCode;

  RemoveFromCartParams(this.productEntity, this.screenCode);
}