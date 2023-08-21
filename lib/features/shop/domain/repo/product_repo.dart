import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../data/repo/util/cart_response.dart';
import '../entity/cart_entity.dart';
import '../entity/product_entity.dart';

abstract class ProductRepo {

  //products
  Future<Either<Failure, List<ProductEntity>>> getProductById(int id,int screenCode);
  Future<Either<Failure, List<ProductEntity>>> getProductsById(List<int> ids,int screenCode);
  Future<Either<Failure, String>> getProductImageById(int id,int screenCode);
  Future<Either<Failure, List<ProductEntity>>> getProducts(int pageNumber,int screenCode);

  //cart
  Future<Either<Failure, void>> addToCart(ProductEntity productEntity,int screenCode);
  Future<Either<Failure, List<CartResponse>>> getCart(int screenCode);
  Future<Either<Failure, void>> removeFromCart(ProductEntity productEntity,int screenCode);
  Future<Either<Failure, void>> updateCartProduct(CartEntity productEntity,int screenCode);

  //search
  Future<Either<Failure, List<ProductEntity>>> searchProduct(String searchTerm,int screenCode);

}