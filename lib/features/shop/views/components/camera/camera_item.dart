import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/config/app_images.dart';
import 'package:eng_shop/core/config/app_theme.dart';
import 'package:eng_shop/core/views/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../../generated/locale_keys.g.dart';

class CameraItem extends StatelessWidget {
  void Function()? onTap;

  CameraItem({super.key,this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 86.w,
        height: 30.h,
        decoration: BoxDecoration(
          color: AppTheme.neutral100,
          borderRadius: BorderRadius.circular(4.w)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppImages.camera,width: 16.w,height: 16.w,),
            Space(height: 3.h,),
            Text(LocaleKeys.camera_sub_text.tr(), style: AppTheme.textL2TextStyle(),),
          ],
        ),
      ),
    );
  }
}
