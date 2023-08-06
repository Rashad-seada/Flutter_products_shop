import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/features/auth/views/bloc/reset_password/reset_password_cubit.dart';
import 'package:eng_shop/features/auth/views/screens/password_reset_screen.dart';
import 'package:eng_shop/features/auth/views/util/reset_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_images.dart';
import '../../../../core/config/app_strings.dart';
import '../../../../core/config/app_theme.dart';
import '../../../../core/views/widgets/custom_back_button.dart';
import '../../../../core/views/widgets/space.dart';
import '../../../../generated/locale_keys.g.dart';
import '../components/reset_option_item.dart';

class PasswordResetMethodsScreen extends StatelessWidget {
  const PasswordResetMethodsScreen({super.key});

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
              listener: (context, state) {},
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

                            SvgPicture.asset(AppImages.forgotPassword,width: 100.w,height: 16.h,),
                            Space(height: 5.h,),

                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(LocaleKeys.reset_password.tr(), style: AppTheme.heading2TextStyle(),),

                                    Space(height: 1.h,),

                                    Text(LocaleKeys.reset_password_method.tr(), style: AppTheme.textMTextStyle(),),
                                  ],
                                ),
                              ],
                            ),
                            Space(height: 3.5.h,),


                            ResetOptionItem(method: ResetMethod.email,screen: PasswordResetScreen(method: ResetMethod.email,),),
                            Space(height: 1.h,),

                            ResetOptionItem(method: ResetMethod.phoneNumber,screen: PasswordResetScreen(method: ResetMethod.phoneNumber,),),
                            Space(height: 2.h,),



                          ],
                        );
              },
            ),
          ),
        ),
      ),
    ));
  }
}
