import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/shop/domain/entity/category_entity.dart';
import 'package:eng_shop/features/shop/domain/repo/category_repo.dart';


class GetAllCategoriesUsecase implements Usecase<List<CategoryEntity>,GetAllCategoriesParams> {
  CategoryRepo repo ;

  GetAllCategoriesUsecase({required this.repo});

  @override
  Future<Either<Failure, List<CategoryEntity>>> call(GetAllCategoriesParams params) async {
    return await repo.getAllCategories(params.screenCode);
  }
}

class GetAllCategoriesParams {
  int screenCode;

  GetAllCategoriesParams(this.screenCode);
}