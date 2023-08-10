import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:eng_shop/core/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomNavigationBar extends StatelessWidget {
  Function(int)? onTap;
  int currentIndex;


  CustomNavigationBar({super.key,required this.currentIndex,this.onTap});

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
      items: [
        /// Home
        DotNavigationBarItem(
          icon: Icon(Icons.home),
          selectedColor: AppTheme.primary500,
        ),

        /// Likes
        DotNavigationBarItem(
          icon: Icon(Icons.favorite),
          selectedColor: AppTheme.primary500,
        ),

        /// Search
        DotNavigationBarItem(
          icon: Icon(Icons.search),
          selectedColor: AppTheme.primary500,
        ),

        /// Profile
        DotNavigationBarItem(
          icon: Icon(Icons.person),
          selectedColor: AppTheme.primary500,
        ),
      ],
    );
  }
}
