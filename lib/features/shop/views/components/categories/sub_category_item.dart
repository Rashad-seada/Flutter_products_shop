import 'package:eng_shop/core/views/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/config/app_theme.dart';

class SubCategoryItem extends StatelessWidget {
  String label;
  SubCategoryItem({super.key,required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width:10.w,
          height: 10.w,
          padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 1.5.h),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: AppTheme.neutral100,
            shape: BoxShape.circle
          ),
        ),

        Space(height: 2.h,),

        Text(label,style: AppTheme.textMTextStyle(color: AppTheme.neutral900),)
      ],
    );
  }
}
