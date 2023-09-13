
import 'package:eng_shop/core/views/widgets/space.dart';
import 'package:eng_shop/features/payment_methods/views/components/payment_method_card.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_theme.dart';
import '../util/payment_method.dart';

class PaymentMethodSection extends StatelessWidget {
  List<PaymentMethod> paymentMethods;
  void Function(int)? onTap;
  int? selectedIndex;

  PaymentMethodSection({super.key,this.selectedIndex,this.paymentMethods = const [],this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 3.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.neutral100,
        borderRadius: BorderRadius.circular(2.w),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: paymentMethods.length,
        itemBuilder: (BuildContext context, int index) {
          return PaymentMethodCard(
            isSelected: selectedIndex == index,
            icon: paymentMethods[index].icon,
            label: paymentMethods[index].label,
            discription: paymentMethods[index].discription,
            methodImages: paymentMethods[index].methodImages,
            onTap: (){
              if(onTap != null){
                onTap!(index);
              }
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Space(
            height: 2.h,
          );
        },
      ),
    );
  }
}
