import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/shop/domain/entity/category_entity.dart';
import 'package:eng_shop/features/shop/domain/repo/category_repo.dart';


class GetSubCategoriesUsecase implements Usecase<List<CategoryEntity>,GetSubCategoriesParams> {
  CategoryRepo repo ;

  GetSubCategoriesUsecase({required this.repo});

  @override
  Future<Either<Failure, List<CategoryEntity>>> call(GetSubCategoriesParams params) async {
    return await repo.getSubCategoriesById(params.parentCategoryId, params.screenCode);
  }
}

class GetSubCategoriesParams {
  int screenCode;
  int parentCategoryId;
  GetSubCategoriesParams(this.parentCategoryId,this.screenCode);
}