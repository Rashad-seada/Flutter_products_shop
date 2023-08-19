import 'package:cached_network_image/cached_network_image.dart';
import 'package:eng_shop/features/main_feature/domain/entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/config/app_consts.dart';
import '../../../../../core/config/app_images.dart';
import '../../../../../core/config/app_theme.dart';
import '../../../../../core/di/app_module.dart';
import '../../../../../core/views/widgets/main_button.dart';
import '../../../../../core/views/widgets/space.dart';
import '../../../data/data_source/local_data_source/settings_local_data_source.dart';

class CartItem extends StatelessWidget {
  ProductEntity productEntity;
  CartItem({super.key,required this.productEntity});

  Future<String> getImage() async {
    String? domain = await getIt<SettingsLocalDataSource>().getServiceProviderDomain();
    String? url = AppConsts.baseImageUrl(domain!, "${productEntity.itemId}");
    return url;
  }

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
            child: FutureBuilder(
                future: getImage(),
                builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                  if(snapshot.hasData) {
                    return Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.w)
                      ),
                      child: CachedNetworkImage(
                        imageUrl: snapshot.data!,
                        placeholder: (context, url) => Center(child: SvgPicture.asset(AppImages.photo,width: 15.w,height: 15.w,)),
                        errorWidget: (context, url, error) => Center(child: SvgPicture.asset(AppImages.photo,width: 15.w,height: 15.w,)),
                        fit: BoxFit.cover,
                      ),
                    );

                  }else if(snapshot.hasError){
                    return Center(child: SvgPicture.asset(AppImages.photo));
                  }else {
                    return Center(child: SvgPicture.asset(AppImages.photo));

                  }
                }
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
                      Icon(Icons.delete_outline_rounded,color: AppTheme.neutral900,),
                    ],
                  ),

                  Text(
                    "Apple AirPods 2",
                    style: AppTheme.textLTextStyle(),),


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
