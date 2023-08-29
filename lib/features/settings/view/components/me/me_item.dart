import 'package:eng_shop/core/config/app_theme.dart';
import 'package:eng_shop/core/views/widgets/space.dart';
import 'package:eng_shop/features/settings/view/util/me_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class MeItem extends StatelessWidget {
  MeEntity meEntity;
  double size;
  MeItem({super.key,required this.meEntity,this.size = 50});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 15.w,
      height: 25.w,
      child: Center(
        child: Column(
          children: [

            SvgPicture.asset(meEntity.icon,width: 8.w,height: 8.w,),

            Space(
              height: 1.h,
            ),

            Text(meEntity.label,style: AppTheme.textMTextStyle(),maxLines: 2,textAlign: TextAlign.center,)

          ],
        ),
      ),
    );
  }
}
