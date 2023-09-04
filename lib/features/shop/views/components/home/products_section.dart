import 'package:eng_shop/features/shop/views/components/home/small_product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../cart/data/util/cart_response.dart';
import '../../../../cart/view/bloc/cart/cart_cubit.dart';
import '../../../domain/entity/product_entity.dart';

class ProductsSection extends StatelessWidget {
  List<ProductEntity> products;
  List<int> addedToFavoriteProductIds;
  List<CartResponse> cart;

  void Function(ProductEntity,int)? onFavoriteClick;
  void Function(ProductEntity,int)? onCartClick;
  void Function(ProductEntity,int)? onProductClick;

  int? indexOfLoadingFavoriteProduct;
  int? indexOfLoadingCartProduct;

  bool withAddToCart;

  ProductsSection({
    super.key,
    required this.products,
    this.onFavoriteClick,
    this.onProductClick,
    this.addedToFavoriteProductIds = const [],
    this.cart = const [],
    this.indexOfLoadingFavoriteProduct,
    this.indexOfLoadingCartProduct,
    this.withAddToCart = false,
    this.onCartClick,
  });

  int getCartCount(int index){
    int myCartIndex = cart.indexWhere((element) => element.cartEntity.itemId == products[index].itemId);
    return cart[myCartIndex].cartEntity.quantity ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return  GridView.builder(
        itemCount: products.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 3.w,
            crossAxisSpacing: 3.w,
            childAspectRatio: ((withAddToCart)? 1.55 : 1.9) /3
        ),
        itemBuilder: (_,index) {
          return SmallProductItem(
            onDeleteTap: () => context.read<CartCubit>().onDeleteTap(int.parse("${products[index].itemId}"), context),
            onDecrementCartTap: () => context.read<CartCubit>().onDecrementTap(int.parse("${products[index].itemId}"), context),
            onIncrementCartTap: () => context.read<CartCubit>().onIncrementTap(int.parse("${products[index].itemId}"), context),
            cartCount: cart.map((e) => e.cartEntity.itemId).toList().contains(products[index].itemId) ? "${getCartCount(index)}" : "0",

            isAddedToTheCart: cart.map((e) => e.cartEntity.itemId).toList().contains(products[index].itemId),
            withAddToCart: withAddToCart,
            isAddedToFavorite: addedToFavoriteProductIds.contains(products[index].itemId),
            isFavoriteLoading: indexOfLoadingFavoriteProduct == index,

            isCartLoading: indexOfLoadingCartProduct == index,
            productEntity: products[index],
            onAddToFavoriteTap: () {
              if(onFavoriteClick != null){
                onFavoriteClick!(products[index],index);
              }
            },
            onItemTap: (){
              if(onProductClick != null){
                onProductClick!(products[index],index);
              }
            },
            onAddToCartTap: (){
              if(onCartClick != null){
                onCartClick!(products[index],index);
              }
            },
          );
        }
    );
  }
}
