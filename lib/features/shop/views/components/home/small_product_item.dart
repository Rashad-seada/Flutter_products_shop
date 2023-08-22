import 'package:cached_network_image/cached_network_image.dart';
import 'package:eng_shop/core/config/app_consts.dart';
import 'package:eng_shop/core/config/app_theme.dart';
import 'package:eng_shop/core/di/app_module.dart';
import 'package:eng_shop/core/views/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/config/app_images.dart';
import '../../../data/data_source/local_data_source/settings_local_data_source.dart';
import '../../../domain/entity/product_entity.dart';

class SmallProductItem extends StatefulWidget {
  ProductEntity productEntity;
  void Function()? onItemTap;
  void Function()? onAddToFavoriteTap;
  SmallProductItem({super.key,required this.productEntity,this.onItemTap,this.onAddToFavoriteTap});

  @override
  State<SmallProductItem> createState() => _SmallProductItemState();
}

class _SmallProductItemState extends State<SmallProductItem> {

  Future<String> getImage() async {
    String? domain = await getIt<SettingsLocalDataSource>().getServiceProviderDomain();
    String? url = AppConsts.baseImageUrl(domain!, "${widget.productEntity.itemId}");
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: 20.h,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppTheme.neutral100,
          borderRadius: BorderRadius.circular(2.w)
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [



          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              InkWell(
                onTap: widget.onItemTap,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  height: 20.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.neutral100,
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
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${widget.productEntity.atxt}",style: AppTheme.textMTextStyle(),maxLines: 1,overflow: TextOverflow.ellipsis,),

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
                          child: Text("4075 Sold",style: AppTheme.textSTextStyle(color: AppTheme.neutral500),maxLines: 2,overflow: TextOverflow.ellipsis,),
                        ),


                      ],
                    ),

                    Text("KD ${widget.productEntity.price}",style: AppTheme.textLTextStyle(color: AppTheme.primary900),maxLines: 2,overflow: TextOverflow.ellipsis,),
                    Space(height: 1.h,) ,

                  ],
                ),
              ),


            ],
          ),

          InkWell(
            onTap: widget.onAddToFavoriteTap,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(2.w),
              width: 7.w,
              height: 7.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.neutral100,
              ),
              child: SvgPicture.asset(AppImages.heart,width: 4.w,height: 4.w,),
            ),
          ),


        ],
      ),
    );
  }
}
