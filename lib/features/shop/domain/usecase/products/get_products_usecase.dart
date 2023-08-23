import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';

import '../../entity/product_entity.dart';
import '../../repo/product_repo.dart';


class GetProductsUsecase implements Usecase<List<ProductEntity>,GetProductsParams> {
  ProductRepo repo ;

  GetProductsUsecase({required this.repo});

  @override
  Future<Either<Failure, List<ProductEntity>>> call(GetProductsParams params) async {
    return await repo.getProducts(params.pageNumber,params.screenCode);
  }
}

class GetProductsParams {
  int pageNumber;
  int screenCode;

  GetProductsParams(this.pageNumber, this.screenCode,);
}