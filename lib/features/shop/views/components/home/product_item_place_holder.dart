import 'package:eng_shop/core/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import '../../../../../core/config/app_images.dart';
import '../../../../../core/views/widgets/custom_shimmer.dart';
import '../../../../../core/views/widgets/space.dart';

class ProductItemPlaceHolder extends StatelessWidget {
  const ProductItemPlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 86.w,
      height: 25.h,
      decoration: BoxDecoration(
        color: AppTheme.neutral100.withOpacity(.5),
        borderRadius: BorderRadius.circular(2.w)
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [



          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              CustomShimmer(
                baseColor: AppTheme.neutral100,
                highlightColor: AppTheme.neutral200.withOpacity(.5),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  height: 20.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppTheme.neutral100,
                      borderRadius: BorderRadius.circular(2.w)
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Space(height: 1.h,) ,

                    CustomShimmer(
                      baseColor: AppTheme.neutral100,
                      highlightColor: AppTheme.neutral200.withOpacity(.5),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 1.w, horizontal:  1.w),
                        width: 10.w,
                        height: 1.5.h,
                        decoration: BoxDecoration(
                            color: AppTheme.neutral300,
                            borderRadius: BorderRadius.circular(1.w)
                        ),
                      ),
                    ),

                    Space(height: .5.h,) ,


                    CustomShimmer(
                      baseColor: AppTheme.neutral100,
                      highlightColor: AppTheme.neutral200.withOpacity(.5),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 1.w, horizontal:  1.w),
                        width: 20.w,
                        height: 1.5.h,
                        decoration: BoxDecoration(
                            color: AppTheme.neutral300,
                            borderRadius: BorderRadius.circular(1.w)
                        ),
                      ),
                    ),
                    
                    Space(height: 1.h,) ,

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        CustomShimmer(
                            baseColor: AppTheme.neutral100,
                            highlightColor: AppTheme.neutral200.withOpacity(.5),
                            child: Icon(Icons.star_half_rounded,color: Colors.amber,)),

                        Space(width: 1.w,) ,

                        CustomShimmer(
                          baseColor: AppTheme.neutral100,
                          highlightColor: AppTheme.neutral200.withOpacity(.5),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 1.w, horizontal:  1.w),
                            width: 5.w,
                            height: 2.h,
                            decoration: BoxDecoration(
                                color: AppTheme.neutral300,
                                borderRadius: BorderRadius.circular(1.w)
                            ),
                          ),
                        ),

                        Space(width: 1.5.w,) ,

                        CustomShimmer(
                          baseColor: AppTheme.neutral100,
                          highlightColor: AppTheme.neutral200.withOpacity(.5),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 1.w, horizontal:  1.w),
                            width: 0.4.w,
                            height: 2.h,
                            decoration: BoxDecoration(
                                color: AppTheme.neutral300,
                                borderRadius: BorderRadius.circular(1.w)
                            ),
                          ),
                        ),

                        Space(width: 2.w,) ,

                        CustomShimmer(

                          child: Container(
                            width: 10.w,
                            height: 2.h,
                            decoration: BoxDecoration(
                                color: AppTheme.neutral100,
                                borderRadius: BorderRadius.circular(1.w)
                            ),
                          ),
                        ),


                      ],
                    ),

                    Space(height: 0.2.h,) ,

                  ],
                ),
              ),


            ],
          ),

          Container(

            alignment: Alignment.center,
            margin: EdgeInsets.all(2.w),
            width: 7.w,
            height: 7.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.neutral200,
            ),
          ),


        ],
      ),
    );
  }
}
