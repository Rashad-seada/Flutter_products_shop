import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/features/cart/view/bloc/cart/cart_cubit.dart';
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
import '../bloc/order/order_cubit.dart';
import '../components/billing_address_details.dart';

class PaymentUserInfoScreen extends StatelessWidget {
  const PaymentUserInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocConsumer<OrderCubit,OrderState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              body: SizedBox(
                width: 100.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
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
                        areaController: context.read<OrderCubit>().areaController,
                        cityController: context.read<OrderCubit>().cityController,
                        neighborhoodController: context.read<OrderCubit>().neighborhoodController,
                        addressController: context.read<OrderCubit>().addressController,
                        noteController: context.read<OrderCubit>().noteController,
                        saveBillingAddress: context.read<OrderCubit>().saveBillingAddress,
                        onChanged: (_)=> context.read<OrderCubit>().onChanged(_!),
                      ),


                      Space(height: 4.h,),




                      MainButton(
                        height: 7.h,
                        label: Text(LocaleKeys.next.tr(),style: AppTheme.textL2TextStyle(color: AppTheme.neutral100),),
                        onTap: ()=> context.read<OrderCubit>().onNextTap(context,CartSuccess.cart.map((e) => e.cartEntity).toList()),
                      ),

                      Space(height: 5.h,),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
