import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/product_entity.dart';

abstract class ProductRepo {

  //products
  Future<Either<Failure, List<ProductEntity>>> getProductById(int id,int screenCode);
  Future<Either<Failure, List<ProductEntity>>> getProductsById(List<int> ids,int screenCode);
  Future<Either<Failure, String>> getProductImageById(int id,int screenCode);
  Future<Either<Failure, List<ProductEntity>>> getProducts(int pageNumber,int screenCode);
  Future<Either<Failure, void>> dropAllProducts(int screenCode);

}