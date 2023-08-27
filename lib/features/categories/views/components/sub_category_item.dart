import 'package:eng_shop/core/views/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_theme.dart';

class SubCategoryItem extends StatelessWidget {
  String label;
  void Function()? onTap;

  SubCategoryItem({super.key,required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: Column(
          children: [
            Container(
              width:12.w,
              height: 12.w,
              padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 1.5.h),
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                color: AppTheme.neutral100,
                shape: BoxShape.circle
              ),
            ),

            Space(height: 1.h,),

            Text(label,style: AppTheme.textMTextStyle(color: AppTheme.neutral900),maxLines: 2,textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,)
          ],
        ),
      ),
    );
  }
}
