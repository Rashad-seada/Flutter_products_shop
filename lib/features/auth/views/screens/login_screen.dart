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

import '../../../../core/config/app_strings.dart';
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(AppImages.logo,width: 14.w,height: 14.w,)
                          ],
                        ),

                        Space(height: 5.h,),

                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppStrings.login, style: AppTheme.heading2TextStyle(),),

                                Space(height: 1.h,),

                                Text(AppStrings.loginSubTitle, style: AppTheme.textLTextStyle(),),
                              ],
                            ),
                          ],
                        ),

                        Space(height: 3.5.h,),


                        AuthTextField(
                          controller: context.read<LoginCubit>().emailController,
                          label: AppStrings.email,hint: AppStrings.emailHint,prefixIcon: Padding(
                          padding: EdgeInsets.all(1.5.h),
                          child: SvgPicture.asset(AppImages.profile),
                        ),),

                        Space(height: 1.5.h,),

                        AuthTextField(
                          controller: context.read<LoginCubit>().passwordController,
                          label: AppStrings.password,hint: AppStrings.passwordHint,prefixIcon: Padding(
                          padding: EdgeInsets.all(1.5.h),
                          child: SvgPicture.asset(AppImages.lock),
                        ),),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CustomCheckBox(value: true, onChanged: (value){
                                  context.read<LoginCubit>().rememberMe = value!;
                                }),

                                Text(AppStrings.rememberMe,style: AppTheme.textMTextStyle(),),
                              ],
                            ),

                            ClickableText(
                              clickableText: AppStrings.resetPassword,
                              style: AppTheme.textMTextStyle(
                                  color: AppTheme.primary
                              ),
                              onPressed: () => context.read<LoginCubit>().onResetPasswordClick(context),
                            ),
                          ],
                        ),
                        Space(height: 29.h,),


                        ClickableText(
                          clickableText: AppStrings.register,
                          text: AppStrings.dontHaveAnAccount,
                          style: AppTheme.textMTextStyle(
                              color: AppTheme.primary
                          ),
                          onPressed: ()=> context.read<LoginCubit>().onDontHaveAnAccountClick(context),
                        ),
                        Space(height: 1.h,),


                        MainButton(width: 100.w,height: 7.h,label: Text(AppStrings.login,style: AppTheme.textLTextStyle(color: AppTheme.neutral100),),onTap: ()=> context.read<LoginCubit>().onLoginClick(),)


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
}
