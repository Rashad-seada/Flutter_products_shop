import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sizer/sizer.dart';

import '../../../../categories/domain/entities/category_entity.dart';
import 'home_category_item.dart';

class HomeCategoriesSection extends StatelessWidget {
  List<CategoryEntity> categories;
  void Function(int,CategoryEntity)? onSubCategoryItemTap;

  HomeCategoriesSection({super.key, required this.categories,this.onSubCategoryItemTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 21.h,
      child: GridView.builder(

        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3.5 / 3,
        ),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return HomeCategoryItem(
            categoryEntity: categories[index],
            onTap: () {
              if (onSubCategoryItemTap != null) {
                onSubCategoryItemTap!(index, categories[index]);
              }
            },
          );
        },
      ),
    );
  }
}
