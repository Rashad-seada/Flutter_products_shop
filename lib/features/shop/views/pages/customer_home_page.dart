
import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/views/components/error_message.dart';
import 'package:eng_shop/core/views/widgets/custom_flushbar.dart';
import 'package:eng_shop/core/views/widgets/pull_to_refresh.dart';
import 'package:eng_shop/features/auth/domain/util/user_type_enum.dart';
import 'package:eng_shop/features/shop/views/components/home/home_categories_section.dart';
import 'package:eng_shop/features/shop/views/components/home/products_section.dart';
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
import '../../../categories/views/bloc/categories/categories_cubit.dart';
import '../../../favorites/view/bloc/favorite/favorite_cubit.dart';
import '../bloc/home/home_cubit.dart';
import '../bloc/home_customer/home_customer_cubit.dart';
import '../components/home/ad_banner_slider.dart';
import '../components/home/home_categories_section_place_holder.dart';
import '../components/home/products_place_holder_section.dart';

class CustomerHomePage extends StatefulWidget {


  const CustomerHomePage({super.key});

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {

  @override
  void didChangeDependencies() {
    context.read<HomeCustomerCubit>().pageNumber = 1;
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
                  shrinkWrap: true,
                  controller: context.read<HomeCustomerCubit>().scrollController,
                  physics: BouncingScrollPhysics(),
                  children: [

                    Space(height: 2.h,),

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

                    Center(child: (context.read<HomeCustomerCubit>().isCategoriesLoading)? const HomeCategoriesSectionPlaceHolder() : const SizedBox()),

                    (!context.read<HomeCustomerCubit>().isCategoriesLoading)?
                    HomeCategoriesSection(
                        categories: HomeCustomerSuccess.categories,
                        onSubCategoryItemTap: (index,_)=> context.read<CategoriesCubit>().onSubCategoryTap(index,_,context)
                    ): const SizedBox(),


                    Row(
                      children: [
                        Text(LocaleKeys.recommended.tr(), style: AppTheme.textL2TextStyle(),textAlign: TextAlign.center,).tr(),
                      ],
                    ),
                    Space(height: 1.h,),

                    BlocConsumer<FavoriteCubit,FavoriteState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return ProductsSection(
                          addedToFavoriteProductIds: FavoriteSuccess.favoriteIds,
                          onFavoriteClick: (product,index) => context.read<FavoriteCubit>().addFavorites(int.parse("${product.itemId}"),index,context),
                          products: HomeCustomerSuccess.products,
                          indexOfLoadingFavoriteProduct: context.read<FavoriteCubit>().indexOfLoadingFavoriteProduct,
                          indexOfLoadingCartProduct: context.read<CartCubit>().indexOfLoadingCartProduct,
                        );
                      },
                    ),

                    Space(height:2.h,),

                    Center(child: (context.read<HomeCustomerCubit>().isRecommendedLoading)? const ProductsPlaceHolderSection() : const SizedBox()),

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
}





