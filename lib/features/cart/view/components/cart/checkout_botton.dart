import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/config/app_theme.dart';
import 'package:eng_shop/core/views/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/views/widgets/main_button.dart';
import '../../../../../generated/locale_keys.g.dart';

class CheckoutButton extends StatelessWidget {
  int totalItems;
  double totalPrice;
  void Function()? onTap;
  Color color;
  Color textColor;

  CheckoutButton({super.key,this.totalPrice = 0.0 ,this.totalItems = 0,this.onTap,this.color = AppTheme.primary900,this.textColor = AppTheme.neutral100});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.h,
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, -3), // Offset for top shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "$totalPrice KD",
              style: AppTheme.textMTextStyle(color: AppTheme
                  .neutral900),
            ),

            Space(width: 2.w,),

            MainButton(
              width: 40.w,
              height: 5.h,
              label: Text(LocaleKeys.checkout.tr() + "($totalItems)",
                style: AppTheme.textL2TextStyle(color: textColor),),
              onTap: () {
                if(onTap != null){
                  onTap!();
                }
              },
              color: color,
            )


          ],
        ),
      ),
    );
  }
}
