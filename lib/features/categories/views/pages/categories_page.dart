import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/views/widgets/pull_to_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_images.dart';
import '../../../../core/config/app_theme.dart';
import '../../../../core/views/components/error_message.dart';
import '../../../../core/views/widgets/custom_progress_indicator.dart';
import '../../../../core/views/widgets/space.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../core/views/widgets/custom_text_field.dart';
import '../bloc/categories/categories_cubit.dart';
import '../components/categories_section.dart';
import '../components/sub_category_section.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {

  @override
  void initState() {
    context.read<CategoriesCubit>().getAllCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocConsumer<CategoriesCubit, CategoriesState>(
          listener: (context, state) {
            print(state);
          },
          builder: (context, state) {
            return Scaffold(
              body: SizedBox(
                width: 100.w,
                child: PullToRefresh(
                  onRefresh: () async => context.read<CategoriesCubit>().onRefreash(),
                  child: ListView(
                    children: [


                      Space(height: 2.h,),

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
                              child: CustomTextField(
                                height: 5.5.h,
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

                      (state is CategoriesLoading)?
                      CustomProgressIndicator(): SizedBox(),

                      (state is CategoriesFailure)?
                      ErrorMessage(message:CategoriesFailure.myError.message): SizedBox(),

                      (state is! CategoriesFailure )?
                      Padding(
                        padding: EdgeInsets.all(0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CategoriesSection(categories: CategoriesSuccess.categories,onCategoryTap: (index,_)=> context.read<CategoriesCubit>().onCategoryTap(index,_), selectedIndex: context.read<CategoriesCubit>().selectedCategoryIndex,),
                            (state is CategoriesSubLoading)
                                ? Expanded(child: CustomProgressIndicator())
                                :  SubCategorySection(
                              categories: CategoriesSuccess.subCategories.elementAtOrNull(context.read<CategoriesCubit>().selectedCategoryIndex) ?? [],
                              onSubCategoryItemTap: (index,_)=> context.read<CategoriesCubit>().onSubCategoryTap(index,_,context),
                            ),
                          ],
                        ),
                      ):SizedBox()


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
