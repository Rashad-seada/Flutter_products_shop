import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/config/app_images.dart';
import 'package:eng_shop/core/views/components/error_message.dart';
import 'package:eng_shop/core/views/widgets/pull_to_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_theme.dart';
import '../../../../core/di/app_module.dart';
import '../../../../core/services/services.dart';
import '../../../../core/views/widgets/custom_back_button.dart';
import '../../../../core/views/widgets/custom_flushbar.dart';
import '../../../../core/views/widgets/main_button.dart';
import '../../../../core/views/widgets/space.dart';
import '../../../../generated/locale_keys.g.dart';
import '../bloc/cart/cart_cubit.dart';
import '../bloc/category_product/category_product_cubit.dart';
import '../components/cart/cart_item.dart';
import '../components/cart/checkout_botton.dart';

class CartPage extends StatefulWidget {
  bool withBackBotton;
  
  CartPage({super.key,this.withBackBotton = false});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  @override
  void initState() {
    context.read<CartCubit>().getCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit,CartState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            body: SizedBox(
              width: 100.w,
              height: 100.h,
              child: PullToRefresh(
                onRefresh: () async => context.read<CartCubit>().onRefreash(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [

                      Space(height: 2.h,),

                      (widget.withBackBotton)?
                      Row(
                        children: [

                          CustomBackButton(),

                        ],
                      ): SizedBox(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Text(LocaleKeys.cart.tr(),
                            style: AppTheme.heading3TextStyle(),),

                        ],
                      ),

                      Space(height: 2.h,),

                      (state is CartFailure)?
                      ErrorMessage(message: CartFailure.myError.message,) :
                      SizedBox() ,


                      (state is CartLoading)?
                      circleIndicator() :
                      SizedBox(),

                      (CartSuccess.cart.isEmpty &&  state is! CartLoading && state is! CartFailure)?
                      Center(
                        child: Column(
                          children: [

                            Space(height: 10.h,),

                            SvgPicture.asset(AppImages.emptyCart,width: 86.w,height: 60.w,),
                            Space(height: 4.h,),

                            Text(
                              LocaleKeys.cart_sub_text.tr(),
                              style: AppTheme.textL2TextStyle(color: AppTheme.neutral400),textAlign: TextAlign.center,),

                            Space(height: 2.h,),


                          ],
                        ),
                      ) :
                      SizedBox(),


                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: CartSuccess.cart.length,
                        itemBuilder: (_, index) {
                          return CartItem(
                            cartResponse: CartSuccess.cart[index],
                            quantity: CartSuccess.cart[index].cartEntity.quantity!,

                            onIncrementTap: () => context.read<CartCubit>().onIncrementTap(index,context),
                            onDecrementTap: () => context.read<CartCubit>().onDecrementTap(index,context),
                            onDeleteTap: () => context.read<CartCubit>().onDeleteTap(index,context),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Space(height: 2.h,);
                        },
                      ),

                      Space(height: 5.h,),

                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: CheckoutButton(
              totalItems: context.read<CartCubit>().getTotalItems(),
              totalPrice: context.read<CartCubit>().totalPrice,
              onTap: ()=> context.read<CartCubit>().onCheckoutClick(context),
            )
          );
        },
      );
  }

  Widget circleIndicator(){
    return  Padding(
      padding: EdgeInsets.all(3.w),
      child: Center(child: SizedBox(width:4.w,height:4.w,child: CircularProgressIndicator(strokeWidth: .5.w,color: AppTheme.neutral900,))),
    );
  }
}

