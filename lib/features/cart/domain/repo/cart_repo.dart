import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../data/util/cart_response.dart';
import '../entity/cart_entity.dart';
import '../../../shop/domain/entity/product_entity.dart';

abstract class CartRepo {

  //cart
  Future<Either<Failure, void>> addToCart(ProductEntity productEntity,int screenCode);
  Future<Either<Failure, List<CartResponse>>> getCart(int screenCode);
  Future<Either<Failure, void>> removeFromCart(ProductEntity productEntity,int screenCode);
  Future<Either<Failure, void>> updateCartProduct(CartEntity productEntity,int screenCode);
  Future<Either<Failure, void>> clearCartProduct(int screenCode);


}