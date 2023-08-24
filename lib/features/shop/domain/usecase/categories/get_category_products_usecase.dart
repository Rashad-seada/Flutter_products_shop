import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/shop/domain/entity/category_entity.dart';
import 'package:eng_shop/features/shop/domain/entity/product_entity.dart';
import 'package:eng_shop/features/shop/domain/repo/category_repo.dart';


class GetCategoryProductsUsecase implements Usecase<List<ProductEntity>,GetCategoryProductsParams> {
  CategoryRepo repo ;

  GetCategoryProductsUsecase({required this.repo});

  @override
  Future<Either<Failure, List<ProductEntity>>> call(GetCategoryProductsParams params) async {
    return await repo.getCategoryProducts(params.pageNumber,params.categoryEntity, params.screenCode);
  }
}

class GetCategoryProductsParams {
  int pageNumber;
  CategoryEntity categoryEntity;
  int screenCode;
  GetCategoryProductsParams(this.pageNumber,this.categoryEntity,this.screenCode);
}