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
import '../../../shop/views/bloc/home_customer/home_customer_cubit.dart';
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

                      GridView.builder(
                          itemCount: CategoryProductSuccess.products.length,
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
                              productEntity: CategoryProductSuccess.products[index],
                              onAddToFavoriteTap: ()=> context.read<CartCubit>().addToCart(CategoryProductSuccess.products[index],context),
                            );
                          }
                      ),

                      Center(child: (state is CategoryProductLoading)? circleIndicator() : const SizedBox()),

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

  Widget circleIndicator(){
    return  Padding(
      padding: EdgeInsets.all(3.w),
      child: SizedBox(width:4.w,height:4.w,child: CircularProgressIndicator(strokeWidth: .5.w,color: AppTheme.neutral900,)),
    );
  }
}
