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
                                Text(AppStrings.verification, style: AppTheme.heading2TextStyle(),),

                                Space(height: 1.h,),

                                Text(AppStrings.verificationSubText, style: AppTheme.textLTextStyle(),textAlign: TextAlign.center,),
                              ],
                            ),
                            Space(height: 5.h,),

                            Form(
                              key: context.read<ResetPasswordCubit>().pinFormKey,
                              child: PinField(
                                validator: (_)=> context.read<ResetPasswordCubit>().pinValidator(_),
                              ),
                            ),
                            Space(height: 2.h,),

                            ClickableText(
                              onPressed: ()=> context.read<ResetPasswordCubit>().onResendClick(),
                              clickableText: AppStrings.resend,
                              text: AppStrings.didntReceiveCode,
                              style: AppTheme.textLTextStyle(color: AppTheme.primary),
                            ),
                            Space(height: 42.h,),

                            MainButton(
                              width: 100.w,height: 7.h,
                              label: (state is ResetPasswordLoading)?
                              SizedBox(width:8.w,height:8.w,child: CircularProgressIndicator(strokeWidth: .5.w,color: Colors.white,))
                                  :Text(
                                AppStrings.done,
                                style: AppTheme.textLTextStyle(color: AppTheme.neutral100),
                              ),
                              onTap: ()=> context.read<ResetPasswordCubit>().onDoneClick(),
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
}
