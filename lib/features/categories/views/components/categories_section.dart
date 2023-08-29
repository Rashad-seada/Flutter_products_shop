import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sizer/sizer.dart';

import '../../domain/entities/category_entity.dart';
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
          return AnimationConfiguration.staggeredList(
            position: index,
            child: SlideAnimation(
              curve: Curves.linearToEaseOut,
              verticalOffset: 50.0,
              horizontalOffset: -50,
              child: FadeInAnimation(
                curve: Curves.linearToEaseOut,
                child: CategoryItem(
                  categoryEntity: categories[index],
                  onTap: (){
                    if(onCategoryTap != null){
                      onCategoryTap!(index,categories[index]);
                    }
                  },
                  isSelected: selectedIndex == index,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
