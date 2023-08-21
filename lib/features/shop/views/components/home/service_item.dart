import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/config/app_theme.dart';
import 'package:eng_shop/core/views/widgets/space.dart';
import 'package:eng_shop/core/views/widgets/web_view.dart';
import 'package:eng_shop/features/shop/views/util/services.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ServiceItem extends StatelessWidget {
  Service service;
  ServiceItem({super.key,required this.service});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(2.w),
        onTap: (){

          Navigator.push(context,MaterialPageRoute(builder: (_)=> WebView()));

        // if (service.nextScreen != null) {
        // }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        decoration: BoxDecoration(
          color: AppTheme.neutral100,
          borderRadius: BorderRadius.circular(2.w)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                color: AppTheme.neutral200,
                shape: BoxShape.circle
              ),
              child: Image.asset(service.image),

            ),

            Space(height: 2.h,),
            Text(service.serviceName,style: AppTheme.textMTextStyle(),textAlign: TextAlign.center,).tr()
          ],
        ),
      ),
    );
  }
}
