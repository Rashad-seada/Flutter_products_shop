import 'package:cached_network_image/cached_network_image.dart';
import 'package:eng_shop/core/config/app_images.dart';
import 'package:eng_shop/core/config/app_theme.dart';
import 'package:eng_shop/core/views/widgets/main_button.dart';
import 'package:eng_shop/core/views/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 3.w),
      width: 86.w,
      height: 25.h,
      decoration: BoxDecoration(
        color: AppTheme.neutral100,
        borderRadius: BorderRadius.circular(3.w)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.w,
            height: 25.h,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.w)
            ),
            child: CachedNetworkImage(
              imageUrl: "https://www.wirelessearbuds.best/wp-content/uploads/2020/02/710rzW2RGcL._SL1500_-2.jpg",
              placeholder: (context, url) => SvgPicture.asset(AppImages.photo),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),

          Space(width: 3.w,),

          Expanded(
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.favorite_border_rounded),
                    ],
                  ),

                  Text(
                    "Apple AirPods 2",
                    style: AppTheme.textLTextStyle(),),
                  Text(
                    "Music on a more personal note. Adaptive EQ automatically tunes music to your ears. Inward-facing microphones detect what you’re hearing, then adjust low and midrange frequencies to deliver the rich details in every song, customized for you in real time",
                    style: AppTheme.textMTextStyle(),overflow: TextOverflow.ellipsis,maxLines: 2,),



                  Container(

                    padding: EdgeInsets.symmetric(horizontal: 5,vertical: 1),
                    height: 2.h,
                    decoration: BoxDecoration(
                        color: AppTheme.neutral200,
                        borderRadius: BorderRadius.circular(1.w)
                    ),
                    child: Text(
                      "29 sold",
                      style: AppTheme.textMTextStyle(),),
                  ),

                  Text(
                    "LE 2000",
                    style: AppTheme.heading3TextStyle(color: AppTheme.primary900),),

                  MainButton(
                    width: double.infinity,
                    height: 3.h,
                    label: Text(
                      "Add to cart",
                      style: AppTheme.textMTextStyle(color: AppTheme.neutral100),),
                  )

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
