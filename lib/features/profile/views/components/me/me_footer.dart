import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/config/app_theme.dart';
import 'package:eng_shop/features/profile/views/bloc/profile/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/config/app_images.dart';
import '../../../../../core/views/widgets/space.dart';
import '../../../../../generated/locale_keys.g.dart';

class MeFooter extends StatelessWidget {
  const MeFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      width: MediaQuery.of(context).size.width,
      height: 28.h,
      decoration: BoxDecoration(
        color: AppTheme.neutral100,
        border: Border.symmetric(vertical: BorderSide(color: AppTheme.neutral200))
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(onPressed: () async => context.read<ProfileCubit>().onLogoutClick(context) , icon: SvgPicture.asset(AppImages.logout,width: 7.w,height: 7.w,)),
              Space(width: 0.5.w,),

              Text(LocaleKeys.logout.tr(),style: AppTheme.textL1TextStyle(color: AppTheme.neutral400),).tr(),
            ],
          )
        ],
      ),
    );
  }
}
