import 'package:eng_shop/core/config/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../di/app_module.dart';
import '../../infrastructure/services/services.dart';

class CustomBackButton extends StatelessWidget {
  void Function()? onPressed;

  CustomBackButton({super.key,this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(100.w),
        onTap: () {
          if(onPressed != null){
            onPressed!();
          }
          Navigator.pop(context);
        },
        child: SvgPicture.asset(
          (getIt<Services>().localeService.isLtr(context))? AppImages.arrow : AppImages.arrowRight,
          width: 6.w
          ,height: 6.w,
        )
    );
  }
}
