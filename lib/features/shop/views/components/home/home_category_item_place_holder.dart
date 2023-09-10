import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/config/app_theme.dart';
import '../../../../../core/views/widgets/custom_shimmer.dart';
import '../../../../../core/views/widgets/space.dart';

class HomeCategoryItemPlaceHolder extends StatelessWidget {
  const HomeCategoryItemPlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(

      child: Column(
        children: [
          CustomShimmer(
            baseColor: AppTheme.neutral100,
            highlightColor: AppTheme.neutral200.withOpacity(.5),
            child: Container(
              width:12.w,
              height: 12.w,
              padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 1.5.h),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: AppTheme.neutral100,
                  borderRadius: BorderRadius.circular(4.w)
              ),
            ),
          ),

          Space(height: .5.h,),

          CustomShimmer(
            baseColor: AppTheme.neutral100,
            highlightColor: AppTheme.neutral200.withOpacity(.5),
            child: Container(
              width:10.w,
              height: 2.w,
              padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 1.5.h),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: AppTheme.neutral100,
                borderRadius: BorderRadius.circular(1.w)
              ),
            ),
          ),
        ],
      ),
    );
  }
}
