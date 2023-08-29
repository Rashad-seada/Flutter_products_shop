import 'package:eng_shop/features/shop/views/components/home/small_product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../cart/view/bloc/cart/cart_cubit.dart';
import '../../../domain/entity/product_entity.dart';
import '../../bloc/home_customer/home_customer_cubit.dart';

class ProductsForYouSection extends StatelessWidget {
  List<ProductEntity> products;
  void Function()? onAddToFavoriteTap;

  ProductsForYouSection({super.key,required this.products,this.onAddToFavoriteTap});

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
            productEntity: products[index],
            onAddToFavoriteTap: ()=> context.read<CartCubit>().addToCart(HomeCustomerSuccess.products[index],context),
          );
        }
    );
  }
}
