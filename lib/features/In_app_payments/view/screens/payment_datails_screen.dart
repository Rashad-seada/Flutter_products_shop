import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/config/app_images.dart';
import 'package:eng_shop/core/views/widgets/main_button.dart';
import 'package:eng_shop/features/In_app_payments/view/bloc/payment/payment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_theme.dart';
import '../../../../core/views/widgets/custom_back_button.dart';
import '../../../../core/views/widgets/space.dart';
import '../../../../generated/locale_keys.g.dart';
import '../components/payment_details_card.dart';

class PaymentDetailsScreen extends StatelessWidget {

  int totalItemsCount;
  double totalItemsPrice;


  PaymentDetailsScreen({super.key,this.totalItemsCount = 0,this.totalItemsPrice = 0});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocConsumer<PaymentCubit, PaymentState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              body: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Center(
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [

                        Space(height: 2.h,),

                        Stack(
                          children: [

                            CustomBackButton(),

                            Center(
                              child: Text(LocaleKeys.payment_details.tr(),
                                style: AppTheme.heading3TextStyle(),),
                            ),

                          ],
                        ),
                        Space(height: 6.h,),

                        SvgPicture.asset(AppImages.shop,width: 92.w,height: 12.h,),
                        Space(height: 2.5.h,),

                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [

                                Text(LocaleKeys.order_summary.tr(),
                                  style: AppTheme.textL2TextStyle(color: AppTheme.neutral400),),
                                Space(height: 1.h,),

                              ],
                            ),
                          ],
                        ),




                        Space(height: 0.5.h,),


                        PaymentDetailsCard(
                          totalPrice: 299.5,
                          deliveryFees: 5,
                          totalItemCount: totalItemsCount,
                          discounts: 100,
                        ),

                        Space(height: 2.h,),


                        MainButton(
                          height: 7.h,
                          label: Text(LocaleKeys.confirm.tr(),style: AppTheme.textL2TextStyle(color: AppTheme.neutral100),),
                          onTap: ()=> context.read<PaymentCubit>().confirm(context),
                        ),

                        Space(height: 2.h,),


                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
