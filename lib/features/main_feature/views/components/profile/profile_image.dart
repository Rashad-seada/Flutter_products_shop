import 'package:eng_shop/core/config/app_images.dart';
import 'package:eng_shop/core/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class ProfileImage extends StatelessWidget {
  String? image;
  ProfileImage({super.key,this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      clipBehavior: Clip.hardEdge,
      width: 25.w,
      height: 25.w,
      decoration: BoxDecoration(
        color: AppTheme.neutral100,
        shape: BoxShape.circle
      ),
      child: Image.asset(image ?? AppImages.profilePlaceHolder),
    );
  }
}
