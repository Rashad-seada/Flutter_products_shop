import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/config/app_images.dart';
import 'package:eng_shop/core/views/widgets/custom_drawer.dart';
import 'package:eng_shop/features/main_feature/views/bloc/home/home_cubit.dart';
import 'package:eng_shop/features/main_feature/views/components/home/custom_side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_theme.dart';
import '../../../../core/views/widgets/space.dart';
import '../../../../generated/locale_keys.g.dart';
import '../components/home/custom_navigation_bar.dart';
import '../components/home/service_item.dart';

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
                body: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [


                    SizedBox(
                      width: 100.w,
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 7.w),
                          child: Column(
                            children: [

                              Space(height: 4.h,),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  InkWell(
                                    borderRadius: BorderRadius.circular(100.w),
                                      onTap: () => context.read<HomeCubit>().onMenuTap(),
                                      child: SvgPicture.asset(AppImages.menu,width: 8.w,height: 8.w,)
                                  ),

                                  Image.asset(AppImages.logo,width: 10.w,height: 10.w,),

                                ],
                              ),
                              Space(height: 3.h,),

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
                              Space(height: 4.h,),

                              GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                    mainAxisSpacing: 1.h,
                                    crossAxisSpacing: 1.h
                                  ),
                                  itemCount: context.read<HomeCubit>().services.length,
                                  itemBuilder: (_,index) => ServiceItem(service: context.read<HomeCubit>().services[index],),
                              ),

                              Space(height: 10.h,),

                            ],
                          ),
                        ),
                      ),
                    ),
                    CustomNavigationBar(
                      currentIndex: context.read<HomeCubit>().currentIndex ,
                      onTap: (index)=> context.read<HomeCubit>().onNavigationBarTap(index),
                    ),

                  ],
                ) ,
          );
        },
      )
    );
  }
}
