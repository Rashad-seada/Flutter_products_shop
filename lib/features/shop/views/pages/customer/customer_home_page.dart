import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/views/widgets/custom_flushbar.dart';
import 'package:eng_shop/features/auth/domain/util/user_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/config/app_images.dart';
import '../../../../../core/config/app_theme.dart';
import '../../../../../core/views/widgets/space.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../search/views/components/search/search_field.dart';
import '../../bloc/cart/cart_cubit.dart';
import '../../bloc/home/home_cubit.dart';
import '../../components/home/ad_banner_slider.dart';
import '../../components/home/small_product_item.dart';

class CustomerHomePage extends StatelessWidget {
  const CustomerHomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return  BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if(state is HomeFailure){
          CustomFlushBar(
              title: "Error : ${HomeFailure.myError.code()}",
              message: HomeFailure.myError.message,
              context: context
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SizedBox(
            width: 100.w,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.w),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                controller: context.read<HomeCubit>().scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Space(height: 4.h,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        InkWell(
                            borderRadius: BorderRadius.circular(100.w),
                            onTap: () => context.read<HomeCubit>().onMenuTap(UserType.customer),
                            child: SvgPicture.asset(AppImages.menu2,width: 8.w,height: 8.w,)
                        ),

                        InkWell(
                          borderRadius: BorderRadius.circular(100.w),
                          onTap: () {},
                          child: SvgPicture.asset(AppImages.heart,width: 26,height:26,),
                        ),

                      ],
                    ),

                    Space(height: 2.h,),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(LocaleKeys.home.tr(), style: AppTheme.heading2TextStyle(),).tr(),

                        Space(height: 1.h,),

                        Text(LocaleKeys.home_sub_text.tr(), style: AppTheme.textLTextStyle(),textAlign: TextAlign.center,).tr(),
                      ],
                    ),
                    Space(height: 2.h,),

                    AdBannerSlider(
                      ads: const [
                        "https://i.ytimg.com/vi/hBYJDtkLY6Q/maxresdefault.jpg",
                        "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/cyber-monday-clothes-sale-ad-design-template-41ee71b978ca61439cd6bc1ac5332d8b_screen.jpg?ts=1561414497",
                        "https://i.ytimg.com/vi/hBYJDtkLY6Q/maxresdefault.jpg",
                      ],
                    ),

                    Space(height: 3.h,),
                    SearchField(
                      onTap: ()=> context.read<HomeCubit>().onSearchTap(context),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(1.5.h),
                        child: SvgPicture.asset(AppImages.search),
                      ),
                      keyboardType: TextInputType.none,
                      hint: LocaleKeys.search_hint_home.tr(),
                    ),

                    Space(height: 3.h,),



                    Text(LocaleKeys.recommended.tr(), style: AppTheme.textLTextStyle(color: AppTheme.neutral900),textAlign: TextAlign.center,).tr(),
                    Space(height: 2.h,),

                    GridView.builder(
                        itemCount: HomeSuccess.products.length,
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
                            productEntity: HomeSuccess.products[index],
                            onAddToFavoriteTap: ()=> context.read<CartCubit>().addToCart(HomeSuccess.products[index],context),
                          );
                        }
                    ),

                    Center(child: (state is HomeIsLoading)? circleIndicator() : const SizedBox()),

                    Space(height: 14.h,),


                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget circleIndicator(){
    return  Padding(
      padding: EdgeInsets.all(3.w),
      child: SizedBox(width:4.w,height:4.w,child: CircularProgressIndicator(strokeWidth: .5.w,color: AppTheme.neutral900,)),
    );
  }
}

