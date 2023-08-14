import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_images.dart';
import '../../../../core/config/app_theme.dart';
import '../../../../core/views/widgets/space.dart';
import '../../../../generated/locale_keys.g.dart';
import '../bloc/home/home_cubit.dart';
import '../components/home/service_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return SizedBox(
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
                          Text(LocaleKeys.home.tr(), style: AppTheme.heading2TextStyle(),).tr(),

                          Space(height: 1.h,),

                          Text(LocaleKeys.home_sub_text.tr(), style: AppTheme.textLTextStyle(),textAlign: TextAlign.center,).tr(),
                        ],
                      ),
                    ],
                  ),
                  Space(height: 4.h,),

                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
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
        );
      },
    );
  }
}
