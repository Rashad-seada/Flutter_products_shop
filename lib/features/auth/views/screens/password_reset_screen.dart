import 'package:eng_shop/features/auth/views/components/phone_number_field.dart';
import 'package:eng_shop/features/auth/views/bloc/reset_password/reset_password_cubit.dart';
import 'package:eng_shop/features/auth/views/util/reset_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_images.dart';
import '../../../../core/config/app_strings.dart';
import '../../../../core/config/app_theme.dart';
import '../components/auth_text_field.dart';
import '../../../../core/views/widgets/custom_back_button.dart';
import '../../../../core/views/widgets/main_button.dart';
import '../../../../core/views/widgets/space.dart';

class PasswordResetScreen extends StatelessWidget {
  ResetMethod method;

  PasswordResetScreen({super.key,required this.method});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: 100.w,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.w),
            child: SingleChildScrollView(
              child: BlocConsumer<ResetPasswordCubit,ResetPasswordState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  return Column(
                    children: [


                      Space(height: 5.h,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomBackButton(),

                          //Image.asset(AppImages.logo,width: 14.w,height: 14.w,)
                        ],
                      ),

                      Space(height: 5.h,),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppStrings.resetPassword, style: AppTheme.heading2TextStyle(),),

                          Space(height: 1.h,),

                          Text((method == ResetMethod.email)? AppStrings.resetPasswordEmailSubTitle : AppStrings.resetPasswordPhoneSubTitle, style: AppTheme.textMTextStyle(),),
                        ],
                      ),

                      Space(height: 3.5.h,),


                      Form(
                        key: context.read<ResetPasswordCubit>().resetPasswordFormKey,
                        child:(method == ResetMethod.email)? AuthTextField(
                          controller: context.read<ResetPasswordCubit>().emailController,
                          validator: (_) => context.read<ResetPasswordCubit>().validateEmail(),
                          label: AppStrings.email,hint: AppStrings.emailHint,prefixIcon: Padding(
                          padding: EdgeInsets.all(1.5.h),
                          child: SvgPicture.asset(AppImages.email),
                        ),): PhoneNumberField(
                          initialValue: context.read<ResetPasswordCubit>().initPhoneNumber,
                          validator: (value)=> context.read<ResetPasswordCubit>().validatePhoneNumber(),
                          onInputValidated: (value) => context.read<ResetPasswordCubit>().onInputValidated(value),
                          onInputChanged: (number) => context.read<ResetPasswordCubit>().onInputChange(number),
                        ),
                      ),

                      Space(height: 52.h,),


                      MainButton(
                        width: 100.w,
                        height: 7.h,
                        label: Text(AppStrings.resetPassword,style: AppTheme.textLTextStyle(color: AppTheme.neutral100),),
                        onTap: ()=> context.read<ResetPasswordCubit>().onResetPasswordClick(context),
                      ),

                    ],
                  );
                },
              ),
            ),
          ),
        ),
      )
    );
  }
}