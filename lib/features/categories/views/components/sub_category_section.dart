import 'package:eng_shop/features/categories/domain/entities/category_entity.dart';
import 'package:eng_shop/features/categories/views/components/sub_category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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
          return AnimationConfiguration.staggeredList(
            duration: const Duration(milliseconds: 200),
            position: index,
            child: SlideAnimation(
              curve: Curves.linearToEaseOut,
              verticalOffset: 50.0,
              child: FadeInAnimation(
                curve: Curves.linearToEaseOut,
                child: SubCategoryItem(
                  categoryEntity: categories[index],
                  onTap: (){
                    if(onSubCategoryItemTap != null){
                      onSubCategoryItemTap!(index,categories[index]);
                    }
                  },
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}
