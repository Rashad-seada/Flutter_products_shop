import 'package:dartz/dartz.dart';
import 'package:eng_shop/features/main_feature/domain/entity/product_entity.dart';

import '../../../../core/error/failure.dart';

abstract class ProductRepo {

  //products
  Future<Either<Failure, List<ProductEntity>>> getProductById(int id,int screenCode);
  Future<Either<Failure, List<ProductEntity>>> getProductsById(List<int> ids,int screenCode);
  Future<Either<Failure, String>> getProductImageById(int id,int screenCode);
  Future<Either<Failure, List<ProductEntity>>> getProducts(int screenCode);

  //cart
  Future<Either<Failure, void>> addToCart(ProductEntity productEntity,int screenCode);
  Future<Either<Failure, List<ProductEntity>>> getCart(int screenCode);
  Future<Either<Failure, void>> removeFromCart(ProductEntity productEntity,int screenCode);

  //search
  Future<Either<Failure, List<ProductEntity>>> searchProduct(String searchTerm,int screenCode);


}