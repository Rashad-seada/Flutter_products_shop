import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/config/app_theme.dart';
import 'package:eng_shop/core/views/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_images.dart';
import '../../../../core/config/app_strings.dart';
import '../../../../generated/locale_keys.g.dart';
import '../util/reset_method.dart';

class ResetOptionItem extends StatelessWidget {

  Widget screen;
  ResetMethod method;

  ResetOptionItem({super.key,required this.screen,required this.method});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(2.w),
      onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> screen)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        alignment: Alignment.centerLeft,
        width: 100.w,
        height: 8.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.w),
          border: Border.all(color: AppTheme.neutral300)
        ),
        child: Row(
          children: [
            SvgPicture.asset((method == ResetMethod.email)? AppImages.email : AppImages.messages,width: 7.w,height: 7.w,),

            Space(width: 4.w,),

            Text((method == ResetMethod.email)? LocaleKeys.reset_by_email.tr() : LocaleKeys.reset_by_phone.tr() ,style: AppTheme.textMTextStyle(),)
          ],
        ),
      ),
    );
  }
}
