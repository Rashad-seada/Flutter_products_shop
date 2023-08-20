import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/main_feature/domain/entity/cart_entity.dart';
import 'package:eng_shop/features/main_feature/domain/repo/product_repo.dart';

import '../../entity/product_entity.dart';


class UpdateCartUsecase implements Usecase<void,UpdateCartParams> {
  ProductRepo repo ;

  UpdateCartUsecase({required this.repo});

  @override
  Future<Either<Failure, void >> call(UpdateCartParams params) async {
    return await repo.updateCartProduct(params.cartEntity,params.screenCode);
  }
}

class UpdateCartParams {
  int screenCode;
  CartEntity cartEntity;

  UpdateCartParams(this.cartEntity,this.screenCode);
}