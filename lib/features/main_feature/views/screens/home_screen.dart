import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/config/app_images.dart';
import 'package:eng_shop/core/views/widgets/custom_drawer.dart';
import 'package:eng_shop/features/main_feature/views/bloc/home/home_cubit.dart';
import 'package:eng_shop/features/main_feature/views/components/custom_side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_theme.dart';
import '../../../../core/views/widgets/space.dart';
import '../../../../generated/locale_keys.g.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocConsumer<HomeCubit,HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
                key: context.read<HomeCubit>().scaffoldKey,
                drawer: CustomDrawer(
                  child: const CustomSideMenu(),
                ),
                body: SizedBox(
                  width: 100.w,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      child: Column(
                        children: [

                          Space(height: 4.h,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              InkWell(
                                borderRadius: BorderRadius.circular(100.w),
                                  onTap: () => context.read<HomeCubit>().onMenuTap(),
                                  child: SvgPicture.asset(AppImages.menu,width: 8.w,height: 8.w,)
                              )
                            ],
                          ),
                          Space(height: 4.h,),

                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(LocaleKeys.home.tr(), style: AppTheme.heading2TextStyle(),),

                                  Space(height: 1.h,),

                                  Text(LocaleKeys.home_sub_text.tr(), style: AppTheme.textLTextStyle(),textAlign: TextAlign.center,),
                                ],
                              ),
                            ],
                          ),
                          Space(height: 5.h,),

                        ],
                      ),
                    ),
                  ),
                ) ,
              );
        },
      )
    );
  }
}
