import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/features/shop/domain/entity/category_entity.dart';
import 'package:eng_shop/features/shop/domain/entity/product_entity.dart';

abstract class CategoryRepo {

  Future<Either<Failure,List<CategoryEntity>>> getAllCategories(int screenCode);

  Future<Either<Failure,List<CategoryEntity>>> getSubCategoriesById(int parentCategoryId,int screenCode);

  Future<Either<Failure,List<ProductEntity>>> getCategoryProducts(int pageNumber,CategoryEntity categoryEntity,int screenCode);

}