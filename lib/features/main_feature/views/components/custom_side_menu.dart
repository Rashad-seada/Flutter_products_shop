import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/config/app_images.dart';
import 'package:eng_shop/core/config/app_theme.dart';
import 'package:eng_shop/core/views/widgets/space.dart';
import 'package:eng_shop/features/main_feature/views/screens/settings_screen.dart';
import 'package:eng_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import 'menu_item.dart';

class CustomSideMenu extends StatelessWidget {
  const CustomSideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 3.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Row(
                children: [
                  Image.asset(AppImages.logo,width: 10.w,height: 10.w,),
                  Space(width: 2.w,),
                  Text(LocaleKeys.main_menu.tr(),style: AppTheme.heading3TextStyle(color: AppTheme.neutral500),),
                ],
              ),

              InkWell(
                onTap: ()=> Navigator.pop(context),
                borderRadius: BorderRadius.circular(100.w),
                child: SvgPicture.asset(AppImages.cancel,width: 15.w,height: 15.w,)
              )

            ],
          ),
          Space(height: 2.h,),

          Divider(),

          Space(height: 2.h,),

          MenuItem(text: LocaleKeys.language.tr(), icon: AppImages.global,),

          Space(height: .5.h,),

          MenuItem(text: LocaleKeys.settings.tr(), icon: AppImages.setting,screen: const SettingsScreen(),),

        ],
      ),
    );
  }
}
