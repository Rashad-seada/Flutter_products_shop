import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/config/app_theme.dart';
import 'package:eng_shop/core/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_images.dart';
import '../../../../core/views/widgets/custom_text_field.dart';
import '../../../../core/views/widgets/space.dart';
import '../../../../generated/locale_keys.g.dart';
import '../bloc/order/order_cubit.dart';


class PaymentDetailsCard extends StatelessWidget {

  int totalItemCount;
  double totalPrice;
  double deliveryFees;
  double shipFess;
  double discounts;

  PaymentDetailsCard({super.key,this.totalItemCount = 0,this.totalPrice = 0,this.deliveryFees = 0,this.discounts = 0,this.shipFess = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.neutral100,
        borderRadius: BorderRadius.circular(2.w),

      ),

      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text(LocaleKeys.items_total.tr() + " ($totalItemCount)",
                style: AppTheme.textMTextStyle(color: AppTheme.neutral600),),

              Text("$totalPrice KD",
                style: AppTheme.textL2TextStyle(color: AppTheme.neutral900),),

            ],
          ),

          Space(height: 2.5.h,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text(LocaleKeys.ship_fees.tr(),
                style: AppTheme.textMTextStyle(color: AppTheme.neutral600),),

              Text("$shipFess KD",
                style: AppTheme.textL2TextStyle(color: AppTheme.neutral900),),

            ],
          ),
          Space(height: 2.5.h,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text(LocaleKeys.delivery_fees.tr(),
                style: AppTheme.textMTextStyle(color: AppTheme.neutral600),),

              Text("$deliveryFees KD",
                style: AppTheme.textL2TextStyle(color: AppTheme.neutral900),),

            ],
          ),
          Space(height: 2.5.h,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text(LocaleKeys.discounts.tr(),
                style: AppTheme.textMTextStyle(color: AppTheme.neutral600),),

              Text("- $discounts KD",
                style: AppTheme.textL2TextStyle(color: AppTheme.neutral900),),

            ],
          ),
          Space(height: 2.h,),

          Divider(color: AppTheme.neutral300,),

          Space(height: 1.h,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text(LocaleKeys.total.tr(),
                style: AppTheme.textL2TextStyle(color: AppTheme.neutral600),),

              Text("${(deliveryFees + totalPrice) - discounts} KD",
                style: AppTheme.textL2TextStyle(color: AppTheme.neutral900),),

            ],
          ),
          Space(height: 1.h,),

          Divider(color: AppTheme.neutral300,),

          Space(height: 1.h,),

          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: context.read<OrderCubit>().promoController,
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(1.5.h),
                      child: SvgPicture.asset(AppImages.ticket),
                    ),
                    hint: LocaleKeys.promo_code_sub_text.tr(),
                    label: LocaleKeys.promo_code.tr(),
                    onFieldSubmitted: (_)=> context.read<OrderCubit>().apply(context),
                  ),
                ),

                Space(width: 2.w,),


                MainButton(
                  width: 25.w,
                  height: 6.h,
                  label: Text(LocaleKeys.apply.tr(),
                    style: AppTheme.textMTextStyle(color: AppTheme.neutral100),),
                )
              ],
            ),
          )

        ],
      ),
    );
  }
}
