import 'package:eng_shop/features/shop/views/components/home/product_item_place_holder.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProductsPlaceHolderSection extends StatelessWidget {
  const ProductsPlaceHolderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 6,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 3.w,
            crossAxisSpacing: 3.w,
            childAspectRatio: 2/3
        ),
        itemBuilder: (_,index) {
          return const ProductItemPlaceHolder();
        }
    );
  }
}
