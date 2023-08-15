import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/main_feature/domain/entity/product_entity.dart';
import 'package:eng_shop/features/main_feature/domain/repo/product_repo.dart';


class GetProductsUsecase implements Usecase<List<ProductEntity>,GetProductsParams> {
  ProductRepo repo ;

  GetProductsUsecase({required this.repo});

  @override
  Future<Either<Failure, List<ProductEntity>>> call(GetProductsParams params) async {
    return await repo.getProducts(params.screenCode);
  }
}

class GetProductsParams {
  int screenCode;

  GetProductsParams( this.screenCode);
}