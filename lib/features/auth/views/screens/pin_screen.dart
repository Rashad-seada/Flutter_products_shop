import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/config/app_strings.dart';
import 'package:eng_shop/core/views/widgets/clickable_text.dart';
import 'package:eng_shop/features/auth/views/bloc/reset_password/reset_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_theme.dart';
import '../../../../core/views/widgets/custom_back_button.dart';
import '../../../../core/views/widgets/main_button.dart';
import '../../../../core/views/widgets/space.dart';
import '../../../../generated/locale_keys.g.dart';
import '../components/pin_field.dart';

class PinScreen extends StatelessWidget {

  PinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomBackButton(),
                              ],
                            ),
                            Space(height: 5.h,),

                            Column(
                              children: [
                                Text(LocaleKeys.verification.tr(), style: AppTheme.heading2TextStyle(),),

                                Space(height: 1.h,),

                                Text(LocaleKeys.verification_sub_text.tr(), style: AppTheme.textLTextStyle(),textAlign: TextAlign.center,),
                              ],
                            ),
                            Space(height: 5.h,),

                            Form(
                              key: context.read<ResetPasswordCubit>().pinFormKey,
                              child: PinField(
                                controller: context.read<ResetPasswordCubit>().pinController,
                                validator: (_)=> context.read<ResetPasswordCubit>().pinValidator(_),
                              ),
                            ),
                            Space(height: 2.h,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClickableText(
                                  onPressed: ()=> context.read<ResetPasswordCubit>().onResendClick(context),
                                  clickableText: LocaleKeys.resend.tr(),
                                  text: LocaleKeys.didnt_receive_code.tr(),
                                  style: AppTheme.textLTextStyle(color: AppTheme.primary900),
                                ),

                                (state is ResetPasswordResendSmsLoading)? circleIndicator(AppTheme.neutral900) : SizedBox(),

                              ],
                            ),

                            Space(height: 42.h,),

                            MainButton(
                              width: 100.w,height: 7.h,
                              label: (state is ResetPasswordLoading)? circleIndicator(AppTheme.neutral100) :Text(
                                LocaleKeys.done.tr(),
                                style: AppTheme.textLTextStyle(color: AppTheme.neutral100),
                              ),
                              onTap: ()=> context.read<ResetPasswordCubit>().onDoneClick(context),
                            ),
                            Space(height: 5.h,),

                          ],
                        );
              },
            ),
          ),
        ),
      ) ,
    ));
  }

  Widget circleIndicator(Color color){
    return  Padding(
      padding: EdgeInsets.all(3.w),
      child: SizedBox(width:4.w,height:4.w,child: CircularProgressIndicator(strokeWidth: .5.w,color: color,)),
    );
  }
}
