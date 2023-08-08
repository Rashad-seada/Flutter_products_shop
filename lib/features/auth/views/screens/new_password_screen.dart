import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/features/auth/views/bloc/reset_password/reset_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_images.dart';
import '../../../../core/config/app_theme.dart';
import '../../../../core/views/widgets/custom_back_button.dart';
import '../../../../core/views/widgets/main_button.dart';
import '../../../../core/views/widgets/space.dart';
import '../../../../generated/locale_keys.g.dart';
import '../components/auth_text_field.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SizedBox(
        width: 100.w,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.w),
          child: SingleChildScrollView(
            child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Column(
                          children: [

                            Space(height: 5.h,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomBackButton(),

                              ],
                            ),

                            Space(height: 5.h,),

                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(LocaleKeys.new_password.tr(), style: AppTheme.heading2TextStyle(),),

                                    Space(height: 1.h,),

                                    Text(LocaleKeys.new_password_sub_text.tr(), style: AppTheme.textLTextStyle(),),
                                  ],
                                ),
                              ],
                            ),

                            Space(height: 3.5.h,),

                            Form(
                              key: context.read<ResetPasswordCubit>().newPasswordFormKey,
                              child: Column(
                                children: [
                                  AuthTextField(
                                    validator: (_)=> context.read<ResetPasswordCubit>().validatePassword(),
                                    controller: context.read<ResetPasswordCubit>().passwordController,
                                    label: LocaleKeys.password.tr(),hint: LocaleKeys.password_hint.tr(),prefixIcon: Padding(
                                    padding: EdgeInsets.all(1.5.h),
                                    child: SvgPicture.asset(AppImages.lock),
                                  ),),

                                  Space(height: 1.5.h,),

                                  AuthTextField(
                                    validator: (_)=> context.read<ResetPasswordCubit>().validateRenterPassword(),
                                    controller: context.read<ResetPasswordCubit>().renterPasswordController,
                                    label: LocaleKeys.renter_password.tr(),hint: LocaleKeys.renter_password_hint.tr(),prefixIcon: Padding(
                                    padding: EdgeInsets.all(1.5.h),
                                    child: SvgPicture.asset(AppImages.lock),
                                  ),),

                                ],
                              ),
                            ),

                            Space(height: 40.h,),

                            MainButton(
                              width: 100.w,
                              height: 7.h,
                              label: (state is ResetPasswordLoading)? circleIndicator() :Text(LocaleKeys.done.tr(),style: AppTheme.textLTextStyle(color: AppTheme.neutral100),),
                              onTap: ()=> context.read<ResetPasswordCubit>().onNewPasswordClick(context),
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
