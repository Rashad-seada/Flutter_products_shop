import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/features/settings/view/bloc/settings/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_images.dart';
import '../../../../core/config/app_theme.dart';
import '../../../../core/views/widgets/section_header.dart';
import '../../../../core/views/widgets/space.dart';
import '../../../../generated/locale_keys.g.dart';
import '../components/me/me_section.dart';

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

            Space(height: 4.h,),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Stack(

                    alignment: Alignment.center,
                    children: [

                      Text(LocaleKeys.me.tr(), style: AppTheme.heading3TextStyle(),).tr(),

                      Positioned(
                        right: 0,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(100.w),
                          onTap: () {},
                          child: SvgPicture.asset(AppImages.setting,width: 26,height:26,),
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),

            Space(height: 3.h,),

            MeSection(meEntities: context.read<SettingsCubit>().myOrders, label: LocaleKeys.my_orders.tr(),),


            Space(height: 2.h,),

            MeSection(meEntities: context.read<SettingsCubit>().services, label: LocaleKeys.more_services.tr(),)


          ],
        ),
      ),
    ));
  }
}
