import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/config/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/config/app_theme.dart';
import '../../../../../core/views/widgets/custom_flushbar.dart';
import '../../../../../core/views/widgets/main_button.dart';
import '../../../../../core/views/widgets/space.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../bloc/cart/cart_cubit.dart';
import '../../components/customer/cart_item.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

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
    return Scaffold(
      body: SizedBox(
        width: 100.w,
        height: 100.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.w),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),

            child: BlocConsumer<CartCubit,CartState>(
              listener: (context, state) {
                if(state is CartFailure){
                  CustomFlushBar(
                      title: "Error : ${CartFailure.myError.code()}",
                      message: CartFailure.myError.message,
                      context: context
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: (CartSuccess.cart.isNotEmpty)? MainAxisAlignment.start : MainAxisAlignment.center,
                  children: [

                    Space(height: 4.h,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text(LocaleKeys.cart.tr(),
                          style: AppTheme.heading2TextStyle(),),

                      ],
                    ),

                    Space(height: 2.h,),
                    

                    (state is CartLoading)?
                    circleIndicator() :

                    (CartSuccess.cart.isNotEmpty)?
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
                    ):
                    Center(
                      child: Column(
                        children: [

                          Space(height: 10.h,),

                          SvgPicture.asset(AppImages.emptyCart,width: 86.w,height: 60.w,),
                          Space(height: 4.h,),

                          Text(
                            LocaleKeys.cart_sub_text.tr(),
                            style: AppTheme.textLTextStyle(color: AppTheme.neutral400),textAlign: TextAlign.center,),

                          Space(height: 2.h,),


                        ],
                      ),
                    ),


                    Space(height: 3.h,),

                    (CartSuccess.cart.isNotEmpty)? MainButton(
                      width: 100.w,
                      height: 7.h,
                      label: Text(LocaleKeys.continue_order.tr(),
                        style: AppTheme.textLTextStyle(color: AppTheme
                            .neutral100),),
                      onTap: () {},
                    ) : const SizedBox(),

                    Space(height: 15.h,),

                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget circleIndicator(){
    return  Padding(
      padding: EdgeInsets.all(3.w),
      child: SizedBox(width:4.w,height:4.w,child: CircularProgressIndicator(strokeWidth: .5.w,color: AppTheme.neutral900,)),
    );
  }
}
