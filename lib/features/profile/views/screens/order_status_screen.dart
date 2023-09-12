import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/features/profile/views/bloc/order_status/order_status_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_images.dart';
import '../../../../core/config/app_theme.dart';
import '../../../../core/views/components/error_message.dart';
import '../../../../core/views/widgets/custom_back_button.dart';
import '../../../../core/views/widgets/custom_progress_indicator.dart';
import '../../../../core/views/widgets/space.dart';
import '../../../../generated/locale_keys.g.dart';
import '../components/me/orders_section.dart';

class OrderStatusScreen extends StatefulWidget {
  String label;
  List<int> orderStatus;
  
  
  OrderStatusScreen({
    super.key,
    required this.label,
    required this.orderStatus,
  });

  @override
  State<OrderStatusScreen> createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {

  @override
  void initState() {
    context.read<OrderStatusCubit>().getOrdersByState(widget.orderStatus,context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocConsumer<OrderStatusCubit,OrderStatusState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),

                    shrinkWrap: true,
                    children: [
                      Space(height: 2.h,),

                      Stack(
                        children: [

                          CustomBackButton(),

                          Center(
                            child: Text(
                              widget.label,
                              style: AppTheme.heading3TextStyle(),),
                          ),
                        ],
                      ),


                      Space(height: 2.h,),

                      OrderSection(orders: OrderStatusSuccess.orders,),

                      (state is OrderStatusFailure)?
                      ErrorMessage(message: OrderStatusFailure.myError.message,) :
                      const SizedBox() ,


                      (state is OrderStatusLoading)?
                      CustomProgressIndicator() :
                      const SizedBox(),

                      (OrderStatusSuccess.orders.isEmpty &&  state is! OrderStatusLoading && state is! OrderStatusFailure)?
                      Center(
                        child: Column(
                          children: [

                            Space(height: 10.h,),

                            SvgPicture.asset(AppImages.emptyBox,width: 86.w,height: 60.w,),
                            Space(height: 4.h,),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              child: Text(
                                LocaleKeys.cart_sub_text.tr(),
                                style: AppTheme.textL2TextStyle(color: AppTheme.neutral400),textAlign: TextAlign.center,maxLines: 2,),
                            ),



                          ],
                        ),
                      ) :
                      const SizedBox(),

                      Space(height: 10.h,),

                    ],
                  ),
                ),
              );
        },
      )
    );
  }
}
