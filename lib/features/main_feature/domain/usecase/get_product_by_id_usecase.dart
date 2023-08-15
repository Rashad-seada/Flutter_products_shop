import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/main_feature/domain/entity/product_entity.dart';
import 'package:eng_shop/features/main_feature/domain/repo/product_repo.dart';


class GetProductByIdUsecase implements Usecase<List<ProductEntity>,GetProductByIdParams> {
  ProductRepo repo ;

  GetProductByIdUsecase({required this.repo});

  @override
  Future<Either<Failure, List<ProductEntity>>> call(GetProductByIdParams params) async {
    return await repo.getProductById(params.id, params.screenCode);
  }
}

class GetProductByIdParams {
  int id;
  int screenCode;

  GetProductByIdParams(this.id, this.screenCode);
}