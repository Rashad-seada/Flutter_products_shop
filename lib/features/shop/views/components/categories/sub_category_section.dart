import 'package:eng_shop/features/shop/domain/entity/category_entity.dart';
import 'package:eng_shop/features/shop/views/components/categories/sub_category_item.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SubCategorySection extends StatelessWidget {
  List<CategoryEntity> categories;
  void Function(int,CategoryEntity)? onSubCategoryItemTap;

  SubCategorySection({super.key,required this.categories,this.onSubCategoryItemTap});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: 70.w,
      child: GridView.builder(
        itemCount: categories.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio : 2.6/3,
        ),
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return SubCategoryItem(
            label: categories[index].etxt!,
            onTap: (){
              if(onSubCategoryItemTap != null){
                onSubCategoryItemTap!(index,categories[index]);
              }
            },
          );
        },

      ),
    );
  }
}
