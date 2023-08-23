import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/views/widgets/pull_to_refresh.dart';
import 'package:eng_shop/features/shop/views/bloc/categories/categories_cubit.dart';
import 'package:eng_shop/features/shop/views/components/categories/categories_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_images.dart';
import '../../../../core/config/app_theme.dart';
import '../../../../core/views/widgets/space.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../search/views/components/search/search_field.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocConsumer<CategoriesCubit, CategoriesState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Scaffold(
              body: SizedBox(
                width: 100.w,
                child: PullToRefresh(
                  onRefresh: () => context.read<CategoriesCubit>().onRefreash(),
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [


                      Space(height: 4.h,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Text(LocaleKeys.categories.tr(),
                            style: AppTheme.heading3TextStyle(),),

                        ],
                      ),

                      Space(height: 2.h,),


                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 80.w,
                              child: SearchField(
                                onTap: () =>
                                    context.read<CategoriesCubit>().onSearchTap(
                                        context),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(1.5.h),
                                  child: SvgPicture.asset(AppImages.search),
                                ),
                                keyboardType: TextInputType.none,
                                hint: LocaleKeys.search_hint_home.tr(),
                              ),
                            ),

                            InkWell(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(100.w),
                                onTap: () =>
                                    context.read<CategoriesCubit>()
                                        .onFavoritesClick(),
                                child: SvgPicture.asset(
                                  AppImages.heart, width: 26, height: 26,),
                              ),
                            ),

                          ],
                        ),
                      ),
                      Space(height: 4.h,),

                      CategoriesSection(categories: [1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9,])


                    ],
                  ),
                ),
              ),
            );
          },
        )
    );
  }
}
