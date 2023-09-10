import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';

import '../../entity/product_entity.dart';
import '../../repo/product_repo.dart';


class GetProductsByIdUsecase implements Usecase<List<ProductEntity>,GetProductsByIdParams> {
  ProductRepo repo ;

  GetProductsByIdUsecase({required this.repo});

  @override
  Future<Either<Failure, List<ProductEntity>>> call(GetProductsByIdParams params) async {
    return await repo.getProductsById(params.id, params.screenCode);
  }
}

class GetProductsByIdParams {
  List<int> id;
  int screenCode;

  GetProductsByIdParams(this.id, this.screenCode);
}