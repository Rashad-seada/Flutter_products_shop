import 'package:eng_shop/core/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Expanded(
          child: Container(
            height: .2.h,
            color: AppTheme.neutral300,
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Text("OR",style: AppTheme.textL2TextStyle(),),
        ),

        Expanded(
          child: Container(
            height: .2.h,
            color: AppTheme.neutral300,
          ),
        ),

      ],
    );
  }
}
