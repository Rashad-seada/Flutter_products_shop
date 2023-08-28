
import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/views/components/error_message.dart';
import 'package:eng_shop/core/views/widgets/custom_flushbar.dart';
import 'package:eng_shop/core/views/widgets/pull_to_refresh.dart';
import 'package:eng_shop/features/auth/domain/util/user_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_images.dart';
import '../../../../core/config/app_theme.dart';
import '../../../../core/views/widgets/space.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../core/views/widgets/custom_text_field.dart';
import '../../../cart/view/bloc/cart/cart_cubit.dart';
import '../bloc/home/home_cubit.dart';
import '../bloc/home_customer/home_customer_cubit.dart';
import '../components/home/ad_banner_slider.dart';
import '../components/home/small_product_item.dart';

class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({super.key});

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {

  @override
  void didChangeDependencies() {
    context.read<HomeCustomerCubit>().pageNumber = 1;
    context.read<HomeCustomerCubit>().getProducts();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return  BlocConsumer<HomeCustomerCubit, HomeCustomerState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SizedBox(
            width: 100.w,
            child: PullToRefresh(
              onRefresh: () async  => context.read<HomeCustomerCubit>().onRefresh(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: ListView(
                  controller: context.read<HomeCustomerCubit>().scrollController,
                  physics: BouncingScrollPhysics(),
                  children: [

                    Space(height: 4.h,),

                    Stack(
                      alignment: Alignment.center,
                      children: [

                        Positioned(
                          left: 0,
                          child: InkWell(
                              borderRadius: BorderRadius.circular(100.w),
                              onTap: () => context.read<HomeCubit>().onMenuTap(UserType.customer),
                              child: SvgPicture.asset(AppImages.menu,width: 8.w,height: 8.w,)
                          ),
                        ),

                        Text(LocaleKeys.home.tr(), style: AppTheme.heading3TextStyle(),).tr(),


                        Positioned(
                          right: 0,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(100.w),
                            onTap: () {},
                            child: SvgPicture.asset(AppImages.heart,width: 26,height:26,),
                          ),
                        ),

                      ],
                    ),

                    Space(height: 2.h,),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(LocaleKeys.home_sub_text.tr(), style: AppTheme.textL2TextStyle(),textAlign: TextAlign.center,).tr(),
                      ],
                    ),
                    Space(height: 1.5.h,),

                    CustomTextField(
                      height: 5.5.h,
                      onTap: ()=> context.read<HomeCustomerCubit>().onSearchTap(context),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(1.5.h),
                        child: SvgPicture.asset(AppImages.search),
                      ),
                      keyboardType: TextInputType.none,
                      hint: LocaleKeys.search_hint_home.tr(),
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



                    Row(
                      children: [
                        Text(LocaleKeys.recommended.tr(), style: AppTheme.textL2TextStyle(color: AppTheme.neutral900),textAlign: TextAlign.center,).tr(),
                      ],
                    ),
                    Space(height: 1.h,),

                    GridView.builder(
                        itemCount: HomeCustomerSuccess.products.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 3.w,
                            crossAxisSpacing: 3.w,
                            childAspectRatio: 1.9/3
                        ),
                        itemBuilder: (_,index) {
                          return SmallProductItem(
                            productEntity: HomeCustomerSuccess.products[index],
                            onAddToFavoriteTap: ()=> context.read<CartCubit>().addToCart(HomeCustomerSuccess.products[index],context),
                          );
                        }
                    ),

                    Center(child: (state is HomeCustomerIsLoading)? circleIndicator() : const SizedBox()),

                    Center(child: (state is HomeCustomerFailure)? ErrorMessage(message: HomeCustomerFailure.myError.message,) : const SizedBox()),


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



