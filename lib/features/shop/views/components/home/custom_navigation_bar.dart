import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:eng_shop/core/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomNavigationBar extends StatelessWidget {
  Function(int)? onTap;
  int currentIndex;
  List<DotNavigationBarItem> items;

  CustomNavigationBar({super.key,required this.currentIndex,this.onTap,required this.items});

  @override
  Widget build(BuildContext context) {
    return DotNavigationBar(
      itemPadding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 4.w),
      marginR: EdgeInsets.symmetric(vertical: 2.h,horizontal: 6.w),
      margin: EdgeInsets.symmetric(vertical: 20.w),
      backgroundColor: AppTheme.neutral900,
      currentIndex: currentIndex,
      dotIndicatorColor: AppTheme.neutral900,
      unselectedItemColor: AppTheme.neutral100,
      splashBorderRadius: 50,
      // enableFloatingNavBar: false,
      onTap: onTap,
      items: items
    );
  }
}
