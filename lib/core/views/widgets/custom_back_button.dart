import 'package:eng_shop/core/config/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class CustomBackButton extends StatelessWidget {
  void Function()? onPressed;

  CustomBackButton({super.key,this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(onPressed != null) {
          onPressed!();
        }

        Navigator.pop(context);
      },
      borderRadius: BorderRadius.circular(100.w),
      child: SvgPicture.asset(
        AppImages.arrow,
      ),
    );
  }
}
