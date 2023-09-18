import 'package:cached_network_image/cached_network_image.dart';
import 'package:eng_shop/core/infrastructure/services/locale_service.dart';
import 'package:eng_shop/core/views/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/config/app_consts.dart';
import '../../../../../core/config/app_images.dart';
import '../../../../../core/config/app_theme.dart';
import '../../../../../core/di/app_module.dart';
import '../../../../categories/domain/entities/category_entity.dart';
import '../../../../settings/data/data_source/local/settings_local_data_source.dart';


class HomeCategoryItem extends StatelessWidget {
  CategoryEntity categoryEntity;
  void Function()? onTap;

  HomeCategoryItem({super.key,required this.categoryEntity, this.onTap});


  Future<String> getImage() async {
    String? domain = await getIt<SettingsLocalDataSource>().getServiceProviderDomain();
    String? url = AppConsts.baseCategoryImageUrl(domain!, "${categoryEntity.id}");
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 6.w,
        child: Column(
          children: [
            Container(
              width:12.w,
              height: 12.w,
              padding: EdgeInsets.symmetric(horizontal: 1.w,vertical: 1.h),
              alignment: Alignment.centerLeft,
              decoration:  BoxDecoration(
                  color: AppTheme.neutral100,
                  borderRadius: BorderRadius.circular(4.w)
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
                          placeholder: (context, url) => Center(child: Padding(
                            padding:  EdgeInsets.all(1.w),
                            child: SvgPicture.asset(AppImages.shop2),
                          )),
                          errorWidget: (context, url, error) => Center(child: Padding(
                            padding:  EdgeInsets.all(1.w),
                            child: SvgPicture.asset(AppImages.shop2),
                          )),
                          fit: BoxFit.cover,
                        ),
                      );

                    }else if(snapshot.hasError){
                      return Center(child: Padding(
                        padding:  EdgeInsets.all(1.w),
                        child: SvgPicture.asset(AppImages.shop2),
                      ));
                    }else {
                      return Center(child: Padding(
                        padding:  EdgeInsets.all(1.w),
                        child: SvgPicture.asset(AppImages.shop2),
                      ));

                    }
                  }
              ),
            ),

            Space(height: .5.h,),

            Text("${getIt<LocaleService>().isArabic(context)?  categoryEntity.atxt : categoryEntity.etxt }",style: AppTheme.textS2TextStyle(color: AppTheme.neutral900),maxLines: 2,textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,)
          ],
        ),
      ),
    );
  }
}
