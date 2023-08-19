import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/features/main_feature/views/bloc/cart/cart_cubit.dart';
import 'package:eng_shop/features/main_feature/views/bloc/home/home_cubit.dart';
import 'package:eng_shop/features/main_feature/views/components/customer/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/config/app_theme.dart';
import '../../../../../core/views/widgets/custom_flushbar.dart';
import '../../../../../core/views/widgets/main_button.dart';
import '../../../../../core/views/widgets/space.dart';
import '../../../../../generated/locale_keys.g.dart';

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
                  children: [

                    Space(height: 5.h,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text(LocaleKeys.cart.tr(),
                          style: AppTheme.heading2TextStyle(),),

                      ],
                    ),

                    Space(height: 2.h,),
                    

                    (state is CartLoading)? circleIndicator() : ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: CartSuccess.cart.length,
                      itemBuilder: (_, index) {
                        return CartItem(productEntity: CartSuccess.cart[index],);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Space(height: 2.h,);
                      },
                    ),

                    Space(height: 2.h,),

                    MainButton(
                      width: 100.w,
                      height: 7.h,
                      label: Text(LocaleKeys.login.tr(),
                        style: AppTheme.textLTextStyle(color: AppTheme
                            .neutral100),),
                      onTap: () {},
                    ),

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
