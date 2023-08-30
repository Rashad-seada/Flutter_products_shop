import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SectionHeader extends StatelessWidget {
  String label;
  Widget? preffixLabel;

  SectionHeader({super.key,required this.label,this.preffixLabel});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      width: 100.w,
      height: 6.h,
      decoration: const BoxDecoration(
        color: AppTheme.neutral100,
        border: Border.symmetric(horizontal: BorderSide(color: AppTheme.neutral200))
      ),
      child: Row(
        mainAxisAlignment: (preffixLabel == null)? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
        children: [
          Text(label,style: AppTheme.textMTextStyle(),).tr(),

          (preffixLabel == null)? const SizedBox() : preffixLabel!,
        ],
      ),
    );
  }
}
