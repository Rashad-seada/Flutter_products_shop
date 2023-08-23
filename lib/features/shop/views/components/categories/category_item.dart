import 'package:eng_shop/core/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class CategoryItem extends StatelessWidget {
  String label;
  void Function()? onTap;

  CategoryItem({super.key,required this.label,this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 1.5.h),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: AppTheme.neutral100,
            
          ),
        child: Text(label,style: AppTheme.textMTextStyle(color: AppTheme.neutral900),),
      ),
    );
  }
}
