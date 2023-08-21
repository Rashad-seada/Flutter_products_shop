import 'package:cached_network_image/cached_network_image.dart';
import 'package:eng_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/config/app_consts.dart';
import '../../../../../core/config/app_images.dart';
import '../../../../../core/config/app_theme.dart';
import '../../../../../core/di/app_module.dart';
import '../../../../../core/views/widgets/space.dart';
import '../../../data/data_source/local_data_source/settings_local_data_source.dart';
import '../../../data/repo/util/cart_response.dart';

class CartItem extends StatelessWidget {
  CartResponse cartResponse;
  int quantity;

  void Function()? onIncrementTap;
  void Function()? onDecrementTap;
  void Function()? onDeleteTap;


  CartItem({super.key,required this.cartResponse,this.onIncrementTap,this.onDecrementTap,this.onDeleteTap,required this.quantity});

  Future<String> getImage() async {
    String? domain = await getIt<SettingsLocalDataSource>().getServiceProviderDomain();
    String? url = AppConsts.baseImageUrl(domain!, "${cartResponse.productEntity.itemId}");
    return url;
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 3.w),
      width: 86.w,
      height: 20.h,
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

                  InkWell(
                    onTap: ()=> onDeleteTap!(),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.delete_outline_rounded,color: AppTheme.neutral900,),
                      ],
                    ),
                  ),

                  Text(
                    "${cartResponse.productEntity.etxt}",
                    style: AppTheme.textLTextStyle(),maxLines: 1,overflow: TextOverflow.ellipsis,),


                  Text(
                    "${cartResponse.productEntity.price}",
                    style: AppTheme.heading3TextStyle(color: AppTheme.primary900),),

                  Text(
                    "${LocaleKeys.total} ${cartResponse.productEntity.price! * quantity}",
                    style: AppTheme.textMTextStyle(color: AppTheme.primary900),),

                  Row(
                    children: [

                      InkWell(
                        onTap: onDecrementTap,
                        child: Container(
                          alignment: Alignment.center,
                          width: 10.w,
                          height: 10.w,
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.primary900
                          ),
                          child: Text(
                            "-",
                            style: AppTheme.textLTextStyle(color: AppTheme.neutral100),),
                        ),
                      ),
                      Space(width: 3.w,),

                      Text(
                        "${cartResponse.cartEntity.quantity}",
                        style: AppTheme.textLTextStyle(),),
                      Space(width: 3.w,),

                      InkWell(
                        onTap: onIncrementTap,
                        child: Container(
                          alignment: Alignment.center,
                          width: 10.w,
                          height: 10.w,
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppTheme.primary900
                          ),
                          child: Text(
                            "+",
                            style: AppTheme.textLTextStyle(color: AppTheme.neutral100),
                          ),
                        ),
                      ),

                    ],
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
