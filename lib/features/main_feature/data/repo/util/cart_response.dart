
import 'package:eng_shop/features/main_feature/domain/entity/cart_entity.dart';
import 'package:eng_shop/features/main_feature/domain/entity/product_entity.dart';

class CartResponse {

  CartEntity cartEntity;
  ProductEntity productEntity;

  CartResponse({required this.cartEntity,required this.productEntity});
}