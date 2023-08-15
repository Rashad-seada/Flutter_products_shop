import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/main_feature/domain/entity/product_entity.dart';
import 'package:eng_shop/features/main_feature/domain/repo/product_repo.dart';


class GetCartUsecase implements Usecase<List<ProductEntity>,AddToCartParams> {
  ProductRepo repo ;

  GetCartUsecase({required this.repo});

  @override
  Future<Either<Failure, List<ProductEntity>>> call(AddToCartParams params) async {
    return await repo.getCart(params.screenCode);
  }
}

class AddToCartParams {
  int screenCode;

  AddToCartParams(this.screenCode);
}