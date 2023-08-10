import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import '../../../../../core/config/app_theme.dart';
import '../../../../../core/views/widgets/space.dart';

class LanguageItem extends StatelessWidget {
  String label;
  String image;
  bool isActive;
  Locale locale;
  void Function()? onTap;

  LanguageItem({super.key,required this.label,required this.image,this.isActive = false,this.onTap,required this.locale});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.w),
          child: Column(
            children: [
              Space(height: 1.7.h,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(image,width: 9.w,height: 9.w,),
                      Space(width: 4.w,),
                      Text(label, style: AppTheme.textLTextStyle(color: AppTheme.neutral800),).tr(),
                    ],
                  ),


                  ratioButton(isActive)

                ],
              ),
              Space(height: 1.7.h,),

              Divider()
            ],
          ),
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
