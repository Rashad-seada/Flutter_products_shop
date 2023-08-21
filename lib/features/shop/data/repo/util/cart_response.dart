
import '../../../domain/entity/cart_entity.dart';
import '../../../domain/entity/product_entity.dart';

class CartResponse {

  CartEntity cartEntity;
  ProductEntity productEntity;

  CartResponse({required this.cartEntity,required this.productEntity});
}