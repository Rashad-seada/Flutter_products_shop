import 'package:eng_shop/core/views/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/config/app_theme.dart';
import '../../../../../core/views/widgets/section_header.dart';
import '../../util/me_entity.dart';
import 'me_item.dart';

class MeSection extends StatelessWidget {
  String label;
  List<MeEntity> meEntities;

  MeSection({super.key,required this.label,required this.meEntities});

  @override
  Widget build(BuildContext context) {
    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        SectionHeader(label: label,),

        Space(height: 2.h,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(meEntities.length, (index) => Row(
              children: [

                MeItem(meEntity: meEntities[index],),

                index != meEntities.length ? Space(width: 5.w,) : SizedBox(),
              ],
            )),
          ),
        ),
      ],
    );
  }
}
