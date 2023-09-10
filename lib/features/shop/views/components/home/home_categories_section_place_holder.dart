import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'home_category_item_place_holder.dart';

class HomeCategoriesSectionPlaceHolder extends StatelessWidget {
  const HomeCategoriesSectionPlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 21.h,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 20,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3.5 / 3,
        ),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return const HomeCategoryItemPlaceHolder();
        },
      ),
    );
  }
}
