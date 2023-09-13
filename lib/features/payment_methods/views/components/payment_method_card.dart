import 'package:eng_shop/core/views/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_theme.dart';

class PaymentMethodCard extends StatelessWidget {
  String icon;
  String label;
  String discription;
  List<String> methodImages;
  void Function()? onTap;
  bool isSelected;

  PaymentMethodCard({super.key,required this.icon,required this.label,required this.discription,this.methodImages = const [],this.onTap,this.isSelected = false});

  @override
  Widget build(BuildContext context) {

    return InkWell(
      borderRadius: BorderRadius.circular(2.w),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(3.w),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppTheme.neutral100,
          borderRadius: BorderRadius.circular(2.w),
          border: Border.all(color: AppTheme.neutral300)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                ratioButton(isSelected),
                Space(width: 3.w,),

                SvgPicture.asset(icon),

                Space(width: 2.w,),

                Text(label,style: AppTheme.textL2TextStyle(color: AppTheme.neutral700),)
              ],
            ),

            Divider(
              color: AppTheme.neutral400,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(discription,style: AppTheme.textS1TextStyle(color: AppTheme.neutral500),),


                Row(
                  children: List.generate(methodImages.length, (index) => Row(
                    children: [
                      Space(width: 2.w,),
                      Image.asset(methodImages[index],width: 7.w,height: 7.w,),
                    ],
                  )),
                )
              ],
            )


          ],
        ),
      ),
    );
  }

  Widget ratioButton(bool isActive){

    return AnimatedContainer(
      alignment: Alignment.center,
      width: 5.w,
      height: 5.w,
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
            color: (isActive)? AppTheme.primary900 : AppTheme.neutral300 ,
            width: 0.5.w
        ),
      ),
      child: AnimatedContainer(
        width: 3.w,
        height: 3.w,
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: (isActive)? AppTheme.primary900 : AppTheme.neutral300,
        ),

      ),
    );

  }
}
