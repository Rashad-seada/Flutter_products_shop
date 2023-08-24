import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/config/app_images.dart';
import 'package:eng_shop/core/views/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../generated/locale_keys.g.dart';
import '../../config/app_theme.dart';

class ErrorMessage extends StatelessWidget {

  String message;
  ErrorMessage({super.key,required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Space(height: 10.h,),

        SvgPicture.asset(AppImages.error2,width: 50.w,height: 20.h,),

        Space(height: 3.h,),

        SizedBox(
          width: 50.w,
          child: Text(
            message,
            style: AppTheme.textLTextStyle(color: AppTheme.neutral400),textAlign: TextAlign.center,),
        ),
      ],
    );
  }
}
