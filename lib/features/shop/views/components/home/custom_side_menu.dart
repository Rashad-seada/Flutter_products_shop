import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/config/app_images.dart';
import 'package:eng_shop/core/config/app_theme.dart';
import 'package:eng_shop/core/views/widgets/space.dart';
import 'package:eng_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../settings/view/screens/language_screen.dart';
import '../../../../settings/view/screens/settings_screen.dart';
import '../../bloc/home_customer/home_customer_cubit.dart';
import '../../../../profile/views/screens/profile_screen.dart';
import 'menu_item.dart';

class CustomSideMenu extends StatelessWidget {
  const CustomSideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 3.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Row(
                    children: [
                      Text(LocaleKeys.main_menu.tr(),style: AppTheme.heading3TextStyle(color: AppTheme.neutral800),).tr(),
                    ],
                  ),

                  InkWell(
                      onTap: ()=> Navigator.pop(context),
                      borderRadius: BorderRadius.circular(100.w),
                      child: SvgPicture.asset(AppImages.cancel,width: 15.w,height: 15.w,)
                  )

                ],
              ),
              Space(height: 1.h,),

              Divider(),
              Space(height: 1.5.h,),

              MenuItem(text: LocaleKeys.profile.tr(), icon: AppImages.profileActive,screen: const ProfileScreen(),),

              Space(height: .5.h,),

              MenuItem(text: LocaleKeys.language.tr(), icon: AppImages.global,screen: const LanguageScreen(),),

              Space(height: .5.h,),

              MenuItem(text: LocaleKeys.settings.tr(), icon: AppImages.setting,screen: const SettingsScreen(),),
            ],
          ),



         Row(
           mainAxisAlignment: MainAxisAlignment.start,
           children: [
             IconButton(onPressed: () async => context.read<HomeCustomerCubit>().onLogoutClick(context) , icon: SvgPicture.asset(AppImages.logout)),
             Space(width: 0.5.w,),

             Text(LocaleKeys.logout.tr(),style: AppTheme.heading3TextStyle(color: AppTheme.neutral500),).tr(),

           ],
         )



        ],
      ),
    );
  }
}


