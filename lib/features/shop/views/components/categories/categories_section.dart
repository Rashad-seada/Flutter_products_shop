import 'package:eng_shop/features/shop/views/components/categories/sub_category_item.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'category_item.dart';

class CategoriesSection extends StatelessWidget {

  List categories;

  CategoriesSection({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 30.w,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: categories.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return CategoryItem(label: "Cloth",);
            },
          ),
        ),

        SizedBox(
          width: 70.w,
          child: GridView.builder(
            itemCount: 10,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3
            ),
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return SubCategoryItem(label: 'Baby cloth',);
            },

          ),
        ),

      ],
    );
  }
}
