import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/features/shop/domain/entity/product_entity.dart';
import 'package:eng_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/config/app_consts.dart';
import '../../../../../core/config/app_images.dart';
import '../../../../../core/config/app_theme.dart';
import '../../../../../core/di/app_module.dart';
import '../../../../settings/data/data_source/local/settings_local_data_source.dart';
import '../../../domain/entities/get_orders_entity.dart';


class OrderItem extends StatelessWidget {
  GetOrderItemsEntity order;

  OrderItem({super.key,required this.order});

  Future<String> getImage() async {
    String? domain = await getIt<SettingsLocalDataSource>().getServiceProviderDomain();
    String? url = AppConsts.baseProductImageUrl(domain!, "${order.itemId}");
    return url;
  }

  String date(){
    List formatedData = order.fdate.toString().split("");

    formatedData.insert(4, "/");

    formatedData.insert(7, "/");

    return  formatedData.join();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 81.w,
      height: 15.h,
      decoration: BoxDecoration(
          color: AppTheme.neutral100,
          borderRadius: BorderRadius.circular(2.w)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30.w,
            height: 15.h,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.w)
            ),
            child: FutureBuilder(
                future: getImage(),
                builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                  if(snapshot.hasData) {
                    return Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.w)
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


          Expanded(
            child: SizedBox(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 1.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${order.quantity} ${LocaleKeys.quantity.tr()}",
                          style: AppTheme.textL2TextStyle(),maxLines: 1,overflow: TextOverflow.ellipsis,),


                        Text("${order.totalPrice} KD",
                          style: AppTheme.textL1TextStyle(color: AppTheme.neutral900),),
                      ],
                    ),








                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                        Text(
                          "${date()}",
                          style: AppTheme.textMTextStyle(),maxLines: 1,overflow: TextOverflow.ellipsis,),


                      ],
                    ),

                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
