import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/config/app_images.dart';
import '../../../../../core/config/app_theme.dart';
import '../../../../../core/views/widgets/space.dart';

class RecentSearchItem extends StatelessWidget {
  String label;
  final void Function(String)? onItemTap;
  RecentSearchItem({super.key,required this.label,this.onItemTap});

  final double _rotationAngle = -2.5;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

        if (onItemTap != null) {
          onItemTap!(label); // Pass the tapped entity back
        }

      },
      child: SizedBox(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            children: [
              Space(height: 1.h,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(label, style: AppTheme.textMTextStyle(color: AppTheme.neutral800),).tr(),

                  Transform.rotate(
                      angle: _rotationAngle,
                      child: SvgPicture.asset(AppImages.arrowRight,width: 6.w,height: 6.w,
                      )
                  ),
                ],
              ),
              Space(height: 1.h,),

              Divider()
            ],
          ),
        ),
      ),
    );
  }
}
