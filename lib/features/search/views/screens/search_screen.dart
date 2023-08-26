import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_images.dart';
import '../../../../core/config/app_theme.dart';
import '../../../../core/views/widgets/custom_flushbar.dart';
import '../../../../core/views/widgets/space.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../shop/views/bloc/cart/cart_cubit.dart';
import '../../../shop/views/components/home/small_product_item.dart';
import '../bloc/search/search_cubit.dart';
import '../components/search/recent_search_section.dart';
import '../../../../core/views/widgets/custom_text_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  @override
  void initState() {

    context.read<SearchCubit>().getRecentSearch();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SizedBox(
        width: 100.w,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: BlocConsumer<SearchCubit,SearchState>(
            listener: (context, state) {
              if(state is SearchFailure){
                CustomFlushBar(
                    title: "Error : ${SearchFailure.myError.code()}",
                    message: SearchFailure.myError.message,
                    context: context
                );
              }
            },
            builder: (context, state) {
              return Column(
                children: [

                  Space(height: 3.h,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width:  80.w,
                          child: CustomTextField(
                            controller: context.read<SearchCubit>().searchController,
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(1.5.h),
                              child: SvgPicture.asset(AppImages.search),
                            ),
                            hint: LocaleKeys.search_hint_home.tr(),
                            onFieldSubmitted: (_)=> context.read<SearchCubit>().onSearchSubmitted(context),
                            onChanged: (_)=> context.read<SearchCubit>().onChangeSearch() ,
                          ),
                        ),

                        InkWell(
                          onTap: ()=> context.read<SearchCubit>().onCancelTap(context) ,
                          child: Text(
                            LocaleKeys.cancel.tr(),
                            style: AppTheme.textMTextStyle(color: AppTheme.neutral500),
                            textAlign: TextAlign.center,
                          ).tr()
                        ),

                      ],
                    ),
                  ),

                  Space(height: 3.h,),

                  (SearchSuccess.recentSearches.isNotEmpty )? RecentSearchSection(
                    recentSearchEntities: SearchSuccess.recentSearches,
                    onClearTap: ()=> context.read<SearchCubit>().onClearTap(),
                    onItemTap: (_)=> context.read<SearchCubit>().onRecentSearchTap(_,context),

                  ) : const SizedBox(),

                  Space(height: 2.h,),

                  Center(child: (state is SearchLoading)? circleIndicator() : const SizedBox()),

                  Space(height: 14.h,),

                ],
              );
            },
          ),
        ),
      ),
    ));
  }

  Widget circleIndicator(){
    return  Padding(
      padding: EdgeInsets.all(3.w),
      child: SizedBox(width:4.w,height:4.w,child: CircularProgressIndicator(strokeWidth: .5.w,color: AppTheme.neutral900,)),
    );
  }
}
