import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/features/auth/views/components/phone_number_field.dart';
import 'package:eng_shop/features/auth/views/bloc/reset_password/reset_password_cubit.dart';
import 'package:eng_shop/features/auth/views/util/reset_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/config/app_images.dart';
import '../../../../../core/config/app_strings.dart';
import '../../../../../core/config/app_theme.dart';
import '../../../../../core/views/widgets/custom_flushbar.dart';
import '../../../../../core/views/widgets/custom_progress_indicator.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../components/auth_text_field.dart';
import '../../../../../core/views/widgets/custom_back_button.dart';
import '../../../../../core/views/widgets/main_button.dart';
import '../../../../../core/views/widgets/space.dart';

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
                  if(state is ResetPasswordCubit){
                    CustomFlushBar(
                        title: 'Error : ${ResetPasswordFailure.myFailure.code()}',
                        message: ResetPasswordFailure.myFailure.message,
                        context: context
                    );
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [


                      Space(height: 4.h,),

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
                          Text(LocaleKeys.reset_password.tr(), style: AppTheme.heading2TextStyle(),),

                          Text((method == ResetMethod.email)? LocaleKeys.reset_password_email_sub_title.tr() : LocaleKeys.reset_password_phone_sub_title.tr(), style: AppTheme.textMTextStyle(),),
                        ],
                      ),

                      Space(height: 3.5.h,),


                      Form(
                        key: context.read<ResetPasswordCubit>().resetPasswordFormKey,
                        child:(method == ResetMethod.email)? AuthTextField(
                          controller: context.read<ResetPasswordCubit>().emailController,
                          validator: (_) => context.read<ResetPasswordCubit>().validateEmail(),
                          label: LocaleKeys.email.tr(),hint: LocaleKeys.email_hint.tr(),prefixIcon: Padding(
                          padding: EdgeInsets.all(1.5.h),
                          child: SvgPicture.asset(AppImages.email),
                        ),): PhoneNumberField(
                          initialValue: context.read<ResetPasswordCubit>().initPhoneNumber,
                          validator: (value)=> context.read<ResetPasswordCubit>().validatePhoneNumber(),
                          onInputValidated: (value) => context.read<ResetPasswordCubit>().onInputValidated(value),
                          onInputChanged: (number) => context.read<ResetPasswordCubit>().onInputChange(number),
                        ),
                      ),

                      Space(height: 45.h,),


                      MainButton(
                        width: 100.w,
                        height: 7.h,
                        label: (state is ResetPasswordLoading)? CustomProgressIndicator(color:AppTheme.neutral100) :Text(LocaleKeys.reset_password.tr(),style: AppTheme.textL2TextStyle(color: AppTheme.neutral100),),
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