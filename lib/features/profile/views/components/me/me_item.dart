import 'package:eng_shop/core/config/app_theme.dart';
import 'package:eng_shop/core/views/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../util/me_entity.dart';

class MeItem extends StatelessWidget {
  MeEntity meEntity;
  double size;
  MeItem({super.key,required this.meEntity,this.size = 50});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(meEntity.screen != null) {
          Navigator.push(context,MaterialPageRoute(builder: (_)=> meEntity.screen!));
        }
      },
      borderRadius: BorderRadius.circular(100.w),
      child: SizedBox(
        width: 15.w,
        height: 25.w,
        child: Center(
          child: Column(
            children: [

              SvgPicture.asset(meEntity.icon,width: 6.5.w,height: 6.5.w,),

              Space(
                height: 1.h,
              ),

              Text(meEntity.label,style: AppTheme.textS2TextStyle(),maxLines: 2,textAlign: TextAlign.center,)

            ],
          ),
        ),
      ),
    );
  }
}
