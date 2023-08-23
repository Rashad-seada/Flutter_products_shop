import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';

import '../../repo/product_repo.dart';


class DropAllProductsUsecase implements Usecase<void,DropAllProductsParams> {
  ProductRepo repo ;

  DropAllProductsUsecase({required this.repo});

  @override
  Future<Either<Failure, void>> call(DropAllProductsParams params) async {
    return await repo.dropAllProducts(params.screenCode);
  }
}

class DropAllProductsParams {
  int screenCode;

  DropAllProductsParams( this.screenCode,);
}