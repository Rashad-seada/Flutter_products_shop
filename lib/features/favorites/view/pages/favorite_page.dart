import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/features/favorites/view/bloc/favorite/favorite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_theme.dart';
import '../../../../core/views/components/error_message.dart';
import '../../../../core/views/widgets/custom_back_button.dart';
import '../../../../core/views/widgets/pull_to_refresh.dart';
import '../../../../core/views/widgets/space.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../shop/views/components/home/products_for_you_section.dart';
import '../../../shop/views/components/home/products_place_holder_section.dart';

class FavoritePage extends StatefulWidget {
  bool withBackButton;
  FavoritePage({super.key,this.withBackButton = false});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  @override
  void initState() {
    context.read<FavoriteCubit>().getFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteCubit,FavoriteState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SizedBox(
            width: 100.w,
            child: PullToRefresh(
              onRefresh: () async => context.read<FavoriteCubit>().onRefreash(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: [

                    Space(height: 2.h,),


                    Stack(
                      children: [

                        (widget.withBackButton)? CustomBackButton() : SizedBox(),

                        Center(
                          child: Text(LocaleKeys.favorite.tr(),
                            style: AppTheme.heading3TextStyle(),),
                        ),

                      ],
                    ),

                    Space(height: 2.h,),

                    ProductsForYouSection(
                      addedToFavoriteProductIds: FavoriteSuccess.favoriteIds,
                      onFavoriteClick: (product,index) => context.read<FavoriteCubit>().removeFavorites(int.parse("${product.itemId}"),index,context),
                      products: FavoriteSuccess.products,
                      indexOfLoadingFavoriteProduct: context.read<FavoriteCubit>().indexOfLoadingFavoriteProduct,
                    ),

                    Space(height: 2.h,),

                    Center(child: (state is FavoriteLoading)? const ProductsPlaceHolderSection() : const SizedBox()),

                    Center(child: (state is FavoriteFailure)? ErrorMessage(message: FavoriteFailure.myError.message,) : const SizedBox()),

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
