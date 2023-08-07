import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/config/app_images.dart';
import 'package:eng_shop/core/config/app_theme.dart';
import 'package:eng_shop/features/auth/views/components/auth_text_field.dart';
import 'package:eng_shop/core/views/widgets/clickable_text.dart';
import 'package:eng_shop/core/views/widgets/custom_checkbox.dart';
import 'package:eng_shop/core/views/widgets/main_button.dart';
import 'package:eng_shop/core/views/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/views/widgets/custom_back_button.dart';
import '../../../../generated/locale_keys.g.dart';
import '../bloc/login/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SizedBox(
            width: 100.w,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.w),
              child: BlocConsumer<LoginCubit,LoginState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [

                        Space(height: 5.h,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomBackButton(),

                            Image.asset(AppImages.logo,width: 14.w,height: 14.w,)
                          ],
                        ),

                        Space(height: 5.h,),

                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(LocaleKeys.login.tr(), style: AppTheme.heading2TextStyle(),),

                                Space(height: 1.h,),

                                Text(LocaleKeys.login_sub_title.tr(), style: AppTheme.textLTextStyle(),),
                              ],
                            ),
                          ],
                        ),

                        Space(height: 3.5.h,),


                        Form(
                          key: context.read<LoginCubit>().loginFormKey,
                          child: Column(
                            children: [
                              AuthTextField(
                                controller: context.read<LoginCubit>().emailController,
                                label: LocaleKeys.email.tr(),hint: LocaleKeys.email_hint.tr(),prefixIcon: Padding(
                                padding: EdgeInsets.all(1.5.h),
                                child: SvgPicture.asset(AppImages.profile),
                                ),
                                validator: (_)=> context.read<LoginCubit>().validateEmail(),
                              ),

                              Space(height: 1.5.h,),

                              AuthTextField(
                                controller: context.read<LoginCubit>().passwordController,
                                label: LocaleKeys.password.tr(),hint: LocaleKeys.password_hint.tr(),prefixIcon: Padding(
                                padding: EdgeInsets.all(1.5.h),
                                child: SvgPicture.asset(AppImages.lock),
                                ),
                                validator: (_)=> context.read<LoginCubit>().validatePassword(),
                              ),
                            ],
                        )),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CustomCheckBox(value: true, onChanged: (value){
                                  context.read<LoginCubit>().rememberMe = value!;
                                }),

                                Text(LocaleKeys.remember_me.tr(),style: AppTheme.textMTextStyle(),),
                              ],
                            ),

                            ClickableText(
                              clickableText: LocaleKeys.reset_password.tr(),
                              style: AppTheme.textMTextStyle(
                                  color: AppTheme.primary900
                              ),
                              onPressed: () => context.read<LoginCubit>().onResetPasswordClick(context),
                            ),
                          ],
                        ),
                        Space(height: 26.h,),


                        ClickableText(
                          clickableText: LocaleKeys.register.tr(),
                          text: LocaleKeys.dont_have_an_account.tr(),
                          style: AppTheme.textMTextStyle(
                              color: AppTheme.primary900
                          ),
                          onPressed: ()=> context.read<LoginCubit>().onDontHaveAnAccountClick(context),
                        ),
                        Space(height: .5.h,),


                        MainButton(
                          width: 100.w,
                          height: 7.h,
                          label: (state is LoginLoading)? circleIndicator() :Text(LocaleKeys.login.tr(),style: AppTheme.textLTextStyle(color: AppTheme.neutral100),),
                          onTap: ()=> context.read<LoginCubit>().onLoginClick(context),
                        )


                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        )
    );
  }

  Widget circleIndicator(){
    return  Padding(
      padding: EdgeInsets.all(3.w),
      child: SizedBox(width:4.w,height:4.w,child: CircularProgressIndicator(strokeWidth: .5.w,color: AppTheme.neutral100,)),
    );
  }
}
