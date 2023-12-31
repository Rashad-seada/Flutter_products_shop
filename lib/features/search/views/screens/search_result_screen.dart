import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_images.dart';
import '../../../../core/config/app_theme.dart';
import '../../../../core/views/components/error_message.dart';
import '../../../../core/views/widgets/custom_flushbar.dart';
import '../../../../core/views/widgets/custom_progress_indicator.dart';
import '../../../../core/views/widgets/space.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../cart/view/bloc/cart/cart_cubit.dart';
import '../../../favorites/view/bloc/favorite/favorite_cubit.dart';
import '../../../shop/views/components/home/products_section.dart';
import '../../../shop/views/components/home/products_place_holder_section.dart';
import '../../../shop/views/components/home/small_product_item.dart';
import '../bloc/search/search_cubit.dart';
import '../../../../core/views/widgets/custom_text_field.dart';

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
                            height: 5.5.h,
                            onTap: () {
                              Navigator.pop(context);
                              context.read<SearchCubit>().getRecentSearch();
                            },
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


                  BlocConsumer<CartCubit, CartState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return BlocConsumer<FavoriteCubit,FavoriteState>(
                                      listener: (context, state) {},
                                      builder: (context, state) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                                          child: ProductsSection(
                                            cart : CartSuccess.cart,
                                            withAddToCart: true,
                                            onCartClick: (product,index) => context.read<CartCubit>().addToCart(product,index,  context),
                                            addedToFavoriteProductIds: FavoriteSuccess.favoriteIds,
                                            onFavoriteClick: (product,index) => context.read<FavoriteCubit>().addFavorites(int.parse("${product.itemId}"),index,context),
                                            products: SearchSuccess.products,
                                            indexOfLoadingFavoriteProduct: context.read<FavoriteCubit>().indexOfLoadingFavoriteProduct,
                                            indexOfLoadingCartProduct: context.read<CartCubit>().indexOfLoadingCartProduct,
                                          ),
                                        );
                                      },
                                    );
                    },
                  ),



                  (state is SearchFailure)?
                  ErrorMessage(message:SearchFailure.myError.message): SizedBox(),

                  (state is SearchLoading)? Padding(

                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: ProductsPlaceHolderSection(),
                  ) : SizedBox(),

                  (SearchSuccess.products.isEmpty && state is! SearchFailure && state is! SearchLoading )?
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
                      : const SizedBox(),

                  Space(height: 14.h,),

                ],
              );
            },
          ),
        ),
      ),
    ));
  }
}