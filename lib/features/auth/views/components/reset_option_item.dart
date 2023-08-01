import 'package:eng_shop/core/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ResetOptionItem extends StatelessWidget {
  Widget screen;

  ResetOptionItem({super.key,required this.screen});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(3.w),
      onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> screen)),
      child: Container(
        width: 100.w,
        height: 8.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.w),
          border: Border.all(color: AppTheme.neutral300)
        ),
      ),
    );
  }
}
