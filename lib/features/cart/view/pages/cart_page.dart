import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/config/app_images.dart';
import 'package:eng_shop/core/views/components/error_message.dart';
import 'package:eng_shop/core/views/widgets/pull_to_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_theme.dart';
import '../../../../core/views/widgets/custom_back_button.dart';
import '../../../../core/views/widgets/custom_progress_indicator.dart';
import '../../../../core/views/widgets/space.dart';
import '../../../../generated/locale_keys.g.dart';
import '../bloc/cart/cart_cubit.dart';
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
  void didChangeDependencies() {
    CartSuccess.cart.clear();

    context.read<CartCubit>().getCart();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit,CartState>(
        listener: (context, state) {},
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


                      Stack(
                        children: [

                          (widget.withBackBotton)? CustomBackButton() : SizedBox(),

                          Center(
                            child: Text(LocaleKeys.cart.tr(),
                              style: AppTheme.heading3TextStyle(),),
                          ),

                        ],
                      ),


                      Space(height: 2.h,),

                      (state is CartFailure)?
                      ErrorMessage(message: CartFailure.myError.message,) :
                      SizedBox() ,


                      (state is CartLoading)?
                      CustomProgressIndicator() :
                      SizedBox(),

                      (CartSuccess.cart.isEmpty &&  state is! CartLoading && state is! CartFailure)?
                      Center(
                        child: Column(
                          children: [

                            Space(height: 10.h,),

                            SvgPicture.asset(AppImages.emptyCart,width: 86.w,height: 60.w,),
                            Space(height: 4.h,),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              child: Text(
                                LocaleKeys.cart_sub_text.tr(),
                                style: AppTheme.textL2TextStyle(color: AppTheme.neutral400),textAlign: TextAlign.center,maxLines: 2,),
                            ),

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
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 500),
                            child: SlideAnimation(
                              curve: Curves.linearToEaseOut,
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                curve: Curves.linearToEaseOut,
                                child: CartItem(

                                  cartResponse: CartSuccess.cart[index],
                                  quantity: CartSuccess.cart[index].cartEntity.quantity!,
                                  onIncrementTap: () => context.read<CartCubit>().onIncrementTap(CartSuccess.cart[index].cartEntity.itemId!,context),
                                  onDecrementTap: () => context.read<CartCubit>().onDecrementTap(CartSuccess.cart[index].cartEntity.itemId!,context),
                                  onDeleteTap: () => context.read<CartCubit>().onDeleteTap(CartSuccess.cart[index].cartEntity.itemId!,context),
                                ),
                              ),
                            ),
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
              color: (CartSuccess.cart.isEmpty)? AppTheme.neutral200 : AppTheme.primary900,
              textColor: (CartSuccess.cart.isEmpty)? AppTheme.neutral900 : AppTheme.neutral200,
              totalItems: context.read<CartCubit>().getTotalItems(),
              totalPrice: context.read<CartCubit>().calculateTotalPrice(),
              onTap: () {

                if(CartSuccess.cart.isNotEmpty){
                  context.read<CartCubit>().onCheckoutClick(context);
                }

              },
            )
          );
        },
      );
  }


}

