import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/main_feature/domain/entity/product_entity.dart';
import 'package:eng_shop/features/main_feature/domain/repo/product_repo.dart';


class AddToCartUsecase implements Usecase<void,AddToCartParams> {
  ProductRepo repo ;

  AddToCartUsecase({required this.repo});

  @override
  Future<Either<Failure, void>> call(AddToCartParams params) async {
    return await repo.addToCart(params.productEntity, params.screenCode);
  }
}

class AddToCartParams {
  ProductEntity productEntity;
  int screenCode;

  AddToCartParams(this.productEntity, this.screenCode);
}