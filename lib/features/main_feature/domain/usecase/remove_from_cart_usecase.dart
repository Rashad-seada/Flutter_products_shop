import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/main_feature/domain/entity/product_entity.dart';
import 'package:eng_shop/features/main_feature/domain/repo/product_repo.dart';


class RemoveFromCartUsecase implements Usecase<void,RemoveFromCartParams> {
  ProductRepo repo ;

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