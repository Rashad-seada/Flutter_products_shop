import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/views/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/config/app_images.dart';
import '../../../../../core/config/app_theme.dart';
import '../../../../../generated/locale_keys.g.dart';

class SettingItem extends StatelessWidget {
  String label;
  Widget? nextScreen;

  SettingItem({super.key,required this.label,this.nextScreen});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(nextScreen != null) {
          Navigator.push(context, MaterialPageRoute(builder: (_)=> nextScreen!));
        }
      },
      child: SizedBox(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.w),
          child: Column(
            children: [
              Space(height: 2.h,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(label, style: AppTheme.textLTextStyle(color: AppTheme.neutral800),),

                  SvgPicture.asset(AppImages.arrowRight,width: 6.w,height: 6.w,)
                ],
              ),
              Space(height: 2.h,),

              Divider()
            ],
          ),
        ),
      ),
    );
  }
}
