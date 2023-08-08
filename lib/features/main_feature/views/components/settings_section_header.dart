import 'package:eng_shop/core/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SettingsSectionHeader extends StatelessWidget {
  String label;
  SettingsSectionHeader({super.key,required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      width: 100.w,
      height: 5.h,
      decoration: const BoxDecoration(
        color: AppTheme.neutral100,
        border: Border.symmetric(horizontal: BorderSide(color: AppTheme.neutral300))
      ),
      child: Text(label,style: AppTheme.textMTextStyle(),),
    );
  }
}
