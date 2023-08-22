import 'package:flutter/material.dart';

import '../../../../../core/config/app_theme.dart';

class CustomNavigationBar extends StatefulWidget {
  Function(int)? onTap;
  int currentIndex;
  List<BottomNavigationBarItem> items;

  CustomNavigationBar({super.key,required this.currentIndex,this.onTap,required this.items});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return  BottomNavigationBar(
      backgroundColor: AppTheme.backgroundColor,
      elevation: 20,
      selectedLabelStyle: AppTheme.textMTextStyle(color: AppTheme.neutral900),
      unselectedLabelStyle: AppTheme.textMTextStyle(color: AppTheme.neutral900),
      currentIndex: widget.currentIndex,
      onTap: (index){
        if(widget.onTap != null){
          widget.onTap!(index);
        }
      },
      items: widget.items,
      unselectedItemColor: Colors.white,
      selectedItemColor: AppTheme.neutral900,
    );
  }
}
