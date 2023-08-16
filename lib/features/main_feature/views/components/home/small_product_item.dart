import 'package:cached_network_image/cached_network_image.dart';
import 'package:eng_shop/core/config/app_consts.dart';
import 'package:eng_shop/core/config/app_theme.dart';
import 'package:eng_shop/core/di/app_module.dart';
import 'package:eng_shop/core/views/widgets/space.dart';
import 'package:eng_shop/features/main_feature/data/data_source/local_data_source/settings_local_data_source.dart';
import 'package:eng_shop/features/main_feature/domain/entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/config/app_images.dart';

class SmallProductItem extends StatefulWidget {
  ProductEntity productEntity;

  SmallProductItem({super.key,required this.productEntity});

  @override
  State<SmallProductItem> createState() => _SmallProductItemState();
}

class _SmallProductItemState extends State<SmallProductItem> {

  Future<String> getImage() async {
    String? domain = await getIt<SettingsLocalDataSourceImpl>().getServiceProviderDomain();
    String? url = AppConsts.baseImageUrl(domain!, "${widget.productEntity.id}");

    print(url);
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.w, horizontal:  2.w),
      width: 40.w,
      height: 20.h,
      decoration: BoxDecoration(
        color: AppTheme.neutral100,
        borderRadius: BorderRadius.circular(1.w)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            height: 20.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppTheme.neutral200,
              borderRadius: BorderRadius.circular(1.w)
            ),
            child: FutureBuilder(
                future: getImage(),
                builder: (BuildContext context, AsyncSnapshot<String> snapshot){

                  if(snapshot.hasData) {
                    print(snapshot.data!);
                    return Image.network(snapshot.data!);
                  }else if(snapshot.hasError){
                    return Center(child: SvgPicture.asset(AppImages.photo));
                  }else {
                    return Center(child: SvgPicture.asset(AppImages.photo));

                  }
                }
            ),
          ),

          Text("${widget.productEntity.atxt}",style: AppTheme.textMTextStyle(),maxLines: 2,overflow: TextOverflow.ellipsis,),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Icon(Icons.star_half_rounded,color: Colors.amber,),

              Space(width: 1.w,) ,

              Text("4.7",style: AppTheme.textMTextStyle(color: AppTheme.neutral500),maxLines: 2,overflow: TextOverflow.ellipsis,),

              Space(width: 1.5.w,) ,

              Container(
                padding: EdgeInsets.symmetric(vertical: 1.w, horizontal:  1.w),
                width: 0.4.w,
                height: 2.h,
                decoration: BoxDecoration(
                    color: AppTheme.neutral300,
                    borderRadius: BorderRadius.circular(1.w)
                ),
              ),

              Space(width: 2.w,) ,

              Container(
                padding: EdgeInsets.all(1.w),
                decoration: BoxDecoration(
                    color: AppTheme.neutral200,
                    borderRadius: BorderRadius.circular(1.w)
                ),
                child: Text("4075 Sold",style: AppTheme.textMTextStyle(color: AppTheme.neutral500),maxLines: 2,overflow: TextOverflow.ellipsis,),
              ),


            ],
          ),

          Text("LE 44075",style: AppTheme.textLTextStyle(color: AppTheme.primary900),maxLines: 2,overflow: TextOverflow.ellipsis,),


        ],
      ),
    );
  }
}
