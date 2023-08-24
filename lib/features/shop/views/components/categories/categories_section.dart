import 'package:eng_shop/features/shop/views/components/categories/sub_category_item.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../domain/entity/category_entity.dart';
import 'category_item.dart';

class CategoriesSection extends StatelessWidget {

  List<CategoryEntity> categories;
  void Function(int,CategoryEntity)? onCategoryTap;
  int selectedIndex;

  CategoriesSection({super.key, required this.categories,this.onCategoryTap,required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30.w,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: categories.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return CategoryItem(
            label: categories[index].etxt!,
            onTap: (){
              if(onCategoryTap != null){
                onCategoryTap!(index,categories[index]);
              }
            },
            isSelected: selectedIndex == index,
          );
        },
      ),
    );
  }
}
