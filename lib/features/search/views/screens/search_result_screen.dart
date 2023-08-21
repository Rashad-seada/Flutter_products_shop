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
import '../components/search/search_field.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {

  @override
  void initState() {
    super.initState();

    SearchSuccess.products.clear();
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
                    padding: EdgeInsets.symmetric(horizontal: 7.w),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 70.w,
                          child: SearchField(
                            onTap: ()=> Navigator.pop(context),
                            controller: context.read<SearchCubit>().searchController,
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(1.5.h),
                              child: SvgPicture.asset(AppImages.search),
                            ),
                            hint: LocaleKeys.search_hint_home.tr(),
                            onFieldSubmitted: (_)=> context.read<SearchCubit>().onSearchSubmitted(context),
                            keyboardType: TextInputType.none,
                          ),
                        ),
                        Space(width: 2.w,),

                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              context.read<SearchCubit>().getRecentSearch();
                            } ,
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



                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7.w),
                    child: GridView.builder(
                        itemCount: SearchSuccess.products.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 3.w,
                            crossAxisSpacing: 3.w,
                            childAspectRatio: 2/3
                        ),
                        itemBuilder: (_,index) {
                          return SmallProductItem(
                            productEntity: SearchSuccess.products[index],
                            onAddToFavoriteTap: ()=> context.read<CartCubit>().addToCart(SearchSuccess.products[index],context),
                          );
                        }
                    ),
                  ),

                  Center(
                      child: (state is SearchLoading)?
                      circleIndicator()
                          : (SearchSuccess.products.isEmpty)?
                      Column(
                        children: [
                          Space(height: 10.h,),

                          Image.asset(AppImages.searchPlaceHolder,width: 20.w,height: 20.w,),

                          Space(height: 4.h,),

                          Text(
                            LocaleKeys.search_not_found.tr(),
                            style: AppTheme.textMTextStyle(color: AppTheme.neutral500),
                            textAlign: TextAlign.center,
                          ).tr()

                        ],
                      )
                          : const SizedBox()),

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