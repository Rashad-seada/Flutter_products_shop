import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/features/settings/view/bloc/settings/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_images.dart';
import '../../../../core/config/app_theme.dart';
import '../../../../core/views/widgets/space.dart';
import '../../../../generated/locale_keys.g.dart';
import '../bloc/profile/profile_cubit.dart';
import '../components/me/me_footer.dart';
import '../components/me/me_section.dart';
import '../components/profile/profile_image.dart';

class MePage extends StatelessWidget {
  const MePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        width: 100.w,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [

            Space(height: 2.h,),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Stack(

                    alignment: Alignment.center,
                    children: [

                      Positioned(
                          left: 0,
                          child: ProfileImage(width: 9.w,height: 9.w,onTap: ()=> context.read<ProfileCubit>().onProfileClick(context),),
                      ),

                      Text(LocaleKeys.me.tr(), style: AppTheme.heading3TextStyle(),).tr(),

                      Positioned(
                        right: 0,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(100.w),
                          onTap: () => context.read<ProfileCubit>().onSettengsClick(context),
                          child: SvgPicture.asset(AppImages.setting,width: 26,height:26,),
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),

            Space(height: 3.h,),

            MeSection(meEntities: context.read<ProfileCubit>().myOrders, label: LocaleKeys.my_orders.tr(),),



            MeSection(meEntities: context.read<ProfileCubit>().services, label: LocaleKeys.more_services.tr(),),

            Space(height: 11.h,),

            MeFooter()

          ],
        ),
      ),
    ));
  }
}
