import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/features/In_app_payments/view/bloc/payment/payment_cubit.dart';
import 'package:eng_shop/features/In_app_payments/view/components/billing_address_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_images.dart';
import '../../../../core/config/app_theme.dart';
import '../../../../core/views/widgets/custom_back_button.dart';
import '../../../../core/views/widgets/main_button.dart';
import '../../../../core/views/widgets/space.dart';
import '../../../../generated/locale_keys.g.dart';

class PaymentUserInfoScreen extends StatelessWidget {
  const PaymentUserInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocConsumer<PaymentCubit, PaymentState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              body: SizedBox(
                width: 100.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: ListView(
                    shrinkWrap: true,
                    children: [

                      Space(height: 2.h,),

                      Stack(
                        children: [

                          CustomBackButton(),

                          Center(
                            child: Text(LocaleKeys.user_info.tr(),
                              style: AppTheme.heading3TextStyle(),),
                          ),

                        ],
                      ),
                      Space(height: 6.h,),

                      SvgPicture.asset(AppImages.address3,width: 92.w,height: 12.h,),
                      Space(height: 2.5.h,),

                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [

                              Text(LocaleKeys.billing_address.tr(),
                                style: AppTheme.textL2TextStyle(color: AppTheme.neutral400),),
                              Space(height: 1.h,),

                            ],
                          ),
                        ],
                      ),
                      Space(height: 0.5.h,),


                      BillingAddressDetails(
                        areaController: context.read<PaymentCubit>().areaController,
                        cityController: context.read<PaymentCubit>().cityController,
                        neighborhoodController: context.read<PaymentCubit>().neighborhoodController,
                        addressController: context.read<PaymentCubit>().addressController,
                        noteController: context.read<PaymentCubit>().noteController,
                        saveBillingAddress: context.read<PaymentCubit>().saveBillingAddress,
                        onChanged: (_)=> context.read<PaymentCubit>().onChanged(_!),
                      ),


                      Space(height: 4.h,),


                      MainButton(
                        height: 7.h,
                        label: Text(LocaleKeys.next.tr(),style: AppTheme.textL2TextStyle(color: AppTheme.neutral100),),
                        onTap: ()=> context.read<PaymentCubit>().onNextTap(),
                      ),

                      Space(height: 2.h,),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
