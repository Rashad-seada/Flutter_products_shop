
import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/config/app_theme.dart';
import 'package:eng_shop/core/views/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class MenuItem extends StatelessWidget {
  String icon;
  String text;
  Widget? screen;

  MenuItem({super.key,required this.text,required this.icon,this.screen});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (screen != null){
          Navigator.pop(context);
          Navigator.push(context,MaterialPageRoute(builder: (_)=> screen!));
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Row(

          children: [
            Space(width: 1.w,),

            Container(
              width: 11.w,
              height: 11.w,
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: AppTheme.neutral100,
                borderRadius: BorderRadius.circular(100.w),

              ),
              child: SvgPicture.asset(icon),
            ),

            Space(width: 3.w,),

            Text(text,style: AppTheme.textMTextStyle(),).tr()
          ],
        ),
      ),
    );
  }
}
