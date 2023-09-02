import 'package:eng_shop/features/favorites/view/bloc/favorite/favorite_cubit.dart';
import 'package:eng_shop/features/shop/views/components/home/small_product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../domain/entity/product_entity.dart';

class ProductsForYouSection extends StatelessWidget {
  List<ProductEntity> products;
  List<int> addedToFavoriteProductIds;
  void Function(ProductEntity,int)? onFavoriteClick;
  void Function(ProductEntity,int)? onProductClick;
  int? indexOfLoadingFavoriteProduct;

  ProductsForYouSection({super.key,required this.products,this.onFavoriteClick,this.onProductClick,this.addedToFavoriteProductIds = const [],this.indexOfLoadingFavoriteProduct});

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
            childAspectRatio: 1.9/3
        ),
        itemBuilder: (_,index) {
          return SmallProductItem(
            isAddedToFavorite: addedToFavoriteProductIds.contains(products[index].itemId),
            isFavoriteLoading: indexOfLoadingFavoriteProduct == index,
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
          );
        }
    );
  }
}
