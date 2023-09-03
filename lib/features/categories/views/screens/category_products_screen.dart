import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_images.dart';
import '../../../../core/config/app_theme.dart';
import '../../../../core/di/app_module.dart';
import '../../../../core/infrastructure/services/services.dart';
import '../../../../core/views/components/error_message.dart';
import '../../../../core/views/widgets/space.dart';
import '../../../cart/view/bloc/cart/cart_cubit.dart';
import '../../../favorites/view/bloc/favorite/favorite_cubit.dart';
import '../../../shop/views/bloc/home_customer/home_customer_cubit.dart';
import '../../../shop/views/components/home/products_section.dart';
import '../../../shop/views/components/home/products_place_holder_section.dart';
import '../../../shop/views/components/home/small_product_item.dart';
import '../bloc/category_product/category_product_cubit.dart';

class CategoryProductsScreen extends StatefulWidget {
  const CategoryProductsScreen({super.key});

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    CategoryProductSuccess.products.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocConsumer<CategoryProductCubit, CategoryProductState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              body: SizedBox(
                width: 100.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: ListView(
                    controller: context.read<CategoryProductCubit>().scrollController,
                    physics: BouncingScrollPhysics(),
                    children: [

                      Space(height: 2.h,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          InkWell(
                              borderRadius: BorderRadius.circular(100.w),
                              onTap: () => context.read<CategoryProductCubit>().onBackTap(context),
                              child: SvgPicture.asset(
                                (getIt<Services>().localeService.isLtr(context))? AppImages.arrow : AppImages.arrowRight,
                                width: 6.w
                                ,height: 6.w,
                              )
                          ),

                          Row(
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(100.w),
                                onTap: () => context.read<CategoryProductCubit>().onSearchTap(context),
                                child: SvgPicture.asset(AppImages.search,width: 26,height:26,),
                              ),
                              Space(width: 4.w,),

                              InkWell(
                                borderRadius: BorderRadius.circular(100.w),
                                onTap: () => context.read<CategoryProductCubit>().onCartTap(context),
                                child: SvgPicture.asset(AppImages.cart,width: 26,height:26,),
                              ),
                            ],
                          ),

                        ],
                      ),

                      Space(height: 4.h,),

                    BlocConsumer<CartCubit, CartState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return BlocConsumer<FavoriteCubit,FavoriteState>(
                                            listener: (context, state) {},
                                            builder: (context, state) {
                                              return ProductsSection(
                                                cart: CartSuccess.cart,
                                                withAddToCart: true,
                                                onCartClick: (product,index) => context.read<CartCubit>().addToCart(product, context),
                                                addedToFavoriteProductIds: FavoriteSuccess.favoriteIds,
                                                onFavoriteClick: (product,index) => context.read<FavoriteCubit>().addFavorites(int.parse("${product.itemId}"),index,context),
                                                products: CategoryProductSuccess.products,
                                                indexOfLoadingFavoriteProduct: context.read<FavoriteCubit>().indexOfLoadingFavoriteProduct,
                                              );
                                            },
                                          );
                        },
                      ),


                      Space(height: 2.h,),

                      Center(child: (state is CategoryProductLoading)? ProductsPlaceHolderSection() : const SizedBox()),

                      Center(child: (state is CategoryProductFailure)? ErrorMessage(message: HomeCustomerFailure.myError.message,) : const SizedBox()),


                      Space(height: 14.h,),

                    ],
                  )
                ),
              ),
            );
          },
        ));
  }

}
