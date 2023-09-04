import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/config/app_images.dart';
import 'package:eng_shop/features/order/view/bloc/order/order_cubit.dart';
import 'package:eng_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/config/app_theme.dart';
import '../../../../core/views/widgets/main_button.dart';
import '../../../../core/views/widgets/space.dart';

class OrderCompleteScreen extends StatelessWidget {
  Widget? screen;

  OrderCompleteScreen({super.key,this.screen});


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.w),
            child: Column(
              children: [
                Space(height: 10.h,),

                Lottie.asset(AppImages.doneAnim,width: 50.w,height:50.w ,repeat: false),


                Space(height: 5.h,),
                Column(
                  children: [
                    Text(LocaleKeys.thank_you_order.tr(), style: AppTheme.heading2TextStyle(),),

                    Space(height: 1.h,),

                    Text(LocaleKeys.thank_you_order_sub_text.tr(), style: AppTheme.textL2TextStyle(),textAlign: TextAlign.center,),
                  ],
                ),

                Space(height: 20.h,),


                MainButton(width: 100.w,height: 7.h,label: Text(LocaleKeys.done.tr(),style: AppTheme.textL2TextStyle(color: AppTheme.neutral100),),onTap: () => context.read<OrderCubit>().onDoneClick(context)),

              ],
            ),
          ),
        )
    );
  }
}
