import 'package:cached_network_image/cached_network_image.dart';
import 'package:eng_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/config/app_consts.dart';
import '../../../../../core/config/app_images.dart';
import '../../../../../core/config/app_theme.dart';
import '../../../../../core/di/app_module.dart';
import '../../../../../core/infrastructure/services/locale_service.dart';
import '../../../../../core/views/widgets/space.dart';
import '../../../../settings/data/data_source/local/settings_local_data_source.dart';
import '../../../data/util/cart_response.dart';

class CartItem extends StatelessWidget {
  CartResponse cartResponse;
  int quantity;

  void Function()? onIncrementTap;
  void Function()? onDecrementTap;
  void Function()? onDeleteTap;


  CartItem({super.key,required this.cartResponse,this.onIncrementTap,this.onDecrementTap,this.onDeleteTap,required this.quantity});

  Future<String> getImage() async {
    String? domain = await getIt<SettingsLocalDataSource>().getServiceProviderDomain();
    String? url = AppConsts.baseProductImageUrl(domain!, "${cartResponse.productEntity.itemId}");
    return url;
  }

  @override
  Widget build(BuildContext context) {

    getIt<LocaleService>().isLtr(context);

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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Expanded(
                          child: Text(
                            "${cartResponse.productEntity.etxt}",
                            style: AppTheme.textL2TextStyle(),maxLines: 1,overflow: TextOverflow.ellipsis,),
                        ),

                        InkWell(
                          onTap: ()=> onDeleteTap!(),
                          child: SvgPicture.asset(AppImages.trash),
                        ),
                      ],
                    ),




                    Text("${cartResponse.productEntity.price} KD",
                      style: AppTheme.textL1TextStyle(color: AppTheme.neutral900),),



                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(
                          "${LocaleKeys.total} ${cartResponse.productEntity.price! * quantity}",
                          style: AppTheme.textMTextStyle(color: AppTheme.neutral600),),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [

                            InkWell(
                              onTap: onDecrementTap,
                              child: Container(
                                alignment: Alignment.center,
                                width: 7.w,
                                height: 7.w,
                                clipBehavior: Clip.hardEdge,
                                decoration:  BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight:  Radius.circular((!getIt<LocaleService>().isLtr(context))? 100.w : 0),
                                    bottomRight: Radius.circular((!getIt<LocaleService>().isLtr(context))? 100.w : 0),
                                    topLeft: Radius.circular((getIt<LocaleService>().isLtr(context))? 100.w : 0),
                                    bottomLeft: Radius.circular((getIt<LocaleService>().isLtr(context))? 100.w : 0),
                                  ),
                                  color: AppTheme.primary900
                                ),
                                child: Text(
                                  "-",
                                  style: AppTheme.textL2TextStyle(color: AppTheme.neutral100),),
                              ),
                            ),
                            Space(width: 1.w,),

                            Text(
                              "${cartResponse.cartEntity.quantity}",
                              style: AppTheme.textL1TextStyle(),),
                            Space(width: 1.w,),

                            InkWell(
                              onTap: onIncrementTap,
                              child: Container(
                                alignment: Alignment.center,
                                width: 7.w,
                                height: 7.w,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  color: AppTheme.primary900,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular((getIt<LocaleService>().isLtr(context))? 100.w : 0),
                                    bottomRight: Radius.circular((getIt<LocaleService>().isLtr(context))? 100.w : 0),
                                    topLeft: Radius.circular((!getIt<LocaleService>().isLtr(context))? 100.w : 0),
                                    bottomLeft: Radius.circular((!getIt<LocaleService>().isLtr(context))? 100.w : 0),
                                  )
                                ),
                                child: Text(
                                  "+",
                                  style: AppTheme.textL2TextStyle(color: AppTheme.neutral100),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ],
                    )

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
