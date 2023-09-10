import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/views/widgets/space.dart';
import 'package:eng_shop/features/search/views/components/search/recent_search_item.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/config/app_theme.dart';
import '../../../../../core/views/widgets/section_header.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../domain/entity/recent_search_entity.dart';

class SuggestedSearchSection extends StatelessWidget {
  List<RecentSearchEntity> recentSearchEntities;
  void Function(String)? onItemTap;

  SuggestedSearchSection({super.key,required this.recentSearchEntities,this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(
          label: LocaleKeys.suggested.tr(),

        ),
        Space(height: 1.w,),
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: recentSearchEntities.length,
            itemBuilder: (_,index){
              return RecentSearchItem(
                onItemTap: onItemTap,
                label: recentSearchEntities[index].searchTerm,
              );
            }
        )

      ],
    );
  }
}
