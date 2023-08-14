import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/features/main_feature/views/bloc/serivce_provider/service_provider_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_images.dart';
import '../../../../core/config/app_theme.dart';
import '../../../../core/views/widgets/clickable_text.dart';
import '../../../../core/views/widgets/custom_back_button.dart';
import '../../../../core/views/widgets/main_button.dart';
import '../../../../core/views/widgets/space.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../auth/views/components/auth_text_field.dart';

class ServiceProviderScreen extends StatefulWidget {
  const ServiceProviderScreen({super.key});

  @override
  State<ServiceProviderScreen> createState() => _ServiceProviderScreenState();
}

class _ServiceProviderScreenState extends State<ServiceProviderScreen> {

  @override
  void initState() {
    context.read<ServiceProviderCubit>().initConfig();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        width: 100.w,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.w),
          child: SingleChildScrollView(
            child: BlocConsumer<ServiceProviderCubit, ServiceProviderState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Column(
                          children: [

                            Space(height: 5.h,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                CustomBackButton(),

                                Text(LocaleKeys.service_provider.tr(), style: AppTheme.heading2TextStyle(),),

                                Space(width: 5.w,),

                              ],
                            ),

                            Space(height: 6.h,),


                            SizedBox(
                              width: 86.w,
                              child: Text(LocaleKeys.service_provider_config.tr(), style: AppTheme.textLTextStyle(),),
                            ),

                            Space(height: 1.5.h,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                Icon(Icons.edit,color: AppTheme.primary900,),

                                ClickableText(
                                  clickableText: LocaleKeys.edit.tr(),
                                  style: AppTheme.textMTextStyle(
                                      color: AppTheme.primary900
                                  ),
                                  onPressed: () => context.read<ServiceProviderCubit>().toggleEdit(),
                                ),
                              ],
                            ),

                            Space(height: 1.5.h,),

                            AuthTextField(
                              enabled: context.read<ServiceProviderCubit>().isEditable,
                              controller: context.read<ServiceProviderCubit>().domainController,
                              label: LocaleKeys.domain.tr(),hint: LocaleKeys.domain_hint.tr(),prefixIcon: Padding(
                              padding: EdgeInsets.all(1.5.h),
                              child: SvgPicture.asset(AppImages.globalInActive),
                            ),
                            ),

                            Space(height: 1.5.h,),

                            AuthTextField(
                              enabled: context.read<ServiceProviderCubit>().isEditable,
                              controller: context.read<ServiceProviderCubit>().emailController,
                              label: LocaleKeys.email.tr(),hint: LocaleKeys.email_hint.tr(),prefixIcon: Padding(
                              padding: EdgeInsets.all(1.5.h),
                              child: SvgPicture.asset(AppImages.email),
                            ),
                            ),

                            Space(height: 1.5.h,),

                            AuthTextField(
                              enabled: context.read<ServiceProviderCubit>().isEditable,
                              controller: context.read<ServiceProviderCubit>().passwordController,
                              label: LocaleKeys.password.tr(),hint: LocaleKeys.password_hint.tr(),prefixIcon: Padding(
                              padding: EdgeInsets.all(1.5.h),
                              child: SvgPicture.asset(AppImages.lock),
                            ),
                            ),

                            Space(height: 27.h,),


                            MainButton(
                              width: 100.w,
                              height: 7.h,
                              label: (state is ServiceProviderSavingConfig)? circleIndicator() :Text(LocaleKeys.save.tr(),style: AppTheme.textLTextStyle(color: AppTheme.neutral100),),
                              onTap: ()=> context.read<ServiceProviderCubit>().onSaveClick(context),
                            )

                          ],
                        );
              },
            ),
          ),
        ),
      ),
    ));
  }

  Widget circleIndicator(){
    return  Padding(
      padding: EdgeInsets.all(3.w),
      child: SizedBox(width:4.w,height:4.w,child: CircularProgressIndicator(strokeWidth: .5.w,color: AppTheme.neutral100,)),
    );
  }
}

// SafeArea(
// child: Scaffold(
// body: SizedBox(
// width: 100.w,
// child: Padding(
// padding: EdgeInsets.symmetric(horizontal: 7.w),
// child: SingleChildScrollView(
// child: Column(
// children: [
//
// Space(height: 5.h,),
//
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
//
// CustomBackButton(),
//
// Text(LocaleKeys.service_provider.tr(), style: AppTheme.heading2TextStyle(),),
//
// Space(width: 5.w,),
//
// ],
// ),
//
// Space(height: 4.h,),
//
//
// ],
// ),
// ),
// ),
// ),
// ));