import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/config/app_images.dart';
import 'package:eng_shop/core/views/widgets/custom_progress_indicator.dart';
import 'package:eng_shop/core/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_theme.dart';
import '../../../../core/views/widgets/custom_back_button.dart';
import '../../../../core/views/widgets/space.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../cart/domain/entity/cart_entity.dart';
import '../bloc/order/order_cubit.dart';
import '../components/payment_details_card.dart';

class PaymentDetailsScreen extends StatelessWidget {

  double totalItemsPrice;

  List<CartEntity> products;

  PaymentDetailsScreen({super.key,this.totalItemsPrice = 0,required this.products});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocConsumer<OrderCubit, OrderState>(
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
                          totalPrice: totalItemsPrice,
                          deliveryFees: 0,
                          shipFess: 0,
                          totalItemCount: products.length,
                          discounts: 0,
                        ),

                        Space(height: 2.h,),


                        MainButton(
                          height: 7.h,
                          label: state is OrderLoading ? CustomProgressIndicator(color: AppTheme.neutral100,) : Text(LocaleKeys.confirm.tr(),style: AppTheme.textL2TextStyle(color: AppTheme.neutral100),),
                          onTap: ()=> context.read<OrderCubit>().confirm(context,products,totalItemsPrice.toString()),
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
