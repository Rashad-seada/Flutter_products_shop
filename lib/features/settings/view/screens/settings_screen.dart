import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/features/settings/view/screens/service_provider_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_theme.dart';
import '../../../../core/views/widgets/custom_back_button.dart';
import '../../../../core/views/widgets/space.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../core/views/widgets/section_header.dart';
import '../components/settings/settings_item.dart';
import 'language_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SizedBox(
            width: 100.w,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Space(height: 2.h,),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        CustomBackButton(),

                        Text(LocaleKeys.settings.tr(), style: AppTheme.heading3TextStyle(),),

                        Space(width: 5.w,),

                      ],
                    ),
                  ),

                  Space(height: 3.h,),

                  SectionHeader(label: LocaleKeys.general_settings.tr(),),
                  Space(height: .5.h,),

                  SettingsItem(label: LocaleKeys.service_provider.tr(),nextScreen: const ServiceProviderScreen(),),

                  SettingsItem(label: LocaleKeys.language.tr(),nextScreen: const LanguageScreen(),)

                ],
              ),
            ),
          ),
        )
    );
  }
}
