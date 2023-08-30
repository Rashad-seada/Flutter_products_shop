import 'package:eng_shop/core/config/app_images.dart';
import 'package:eng_shop/core/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';


class ProfileImage extends StatelessWidget {
  String? image;
  double width;
  double height;
  void Function()? onTap;

  ProfileImage({super.key,this.image ,required this.width ,required this.height,this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100.w),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(width / 4.2),
        alignment: Alignment.center,
        clipBehavior: Clip.hardEdge,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppTheme.neutral100,
          shape: BoxShape.circle,
          border: Border.all(color: AppTheme.neutral300)
        ),
        child: SvgPicture.asset(AppImages.profile2,width: width,height: height,),
      ),
    );
  }
}
