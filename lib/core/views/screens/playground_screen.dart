import 'package:eng_shop/core/di/app_module.dart';
import 'package:eng_shop/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../config/app_theme.dart';
import '../widgets/main_button.dart';
import '../widgets/space.dart';

class PlayGroundScreen extends StatelessWidget {
  const PlayGroundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

            MainButton(
              width: 100.w, height: 7.h,
              label: Text(
                "Google Maps",
                style: AppTheme.textLTextStyle(color: AppTheme.neutral100),
              ),
              onTap: () {

              },
            ),
              Space(height: 5.h,),

            MainButton(
                width: 100.w, height: 7.h,
                label: Text(
                    "Listing",
                    style: AppTheme.textLTextStyle(color: AppTheme.neutral100),
              ),
              onTap: () {

              },
            ),
              Space(height: 5.h,),

            MainButton(
              width: 100.w, height: 7.h,
              label: Text(
                  "Camera",
                  style: AppTheme.textLTextStyle(color: AppTheme.neutral100),
              ),
              onTap: () {
                getIt<Services>().cameraService.pickMultiImage();
              },
            ),

            ],
          ),
        ),
      )
    );
  }
}