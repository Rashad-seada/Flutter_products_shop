import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/features/auth/views/bloc/auth_methods/auth_methods_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_images.dart';
import '../../../../core/config/app_theme.dart';
import '../../../../core/views/widgets/custom_divider.dart';
import '../../../../core/views/widgets/main_button.dart';
import '../../../../core/views/widgets/space.dart';
import '../../../../generated/locale_keys.g.dart';

class AuthMethodsScreen extends StatelessWidget {
  const AuthMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SizedBox(
            width: 100.w,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.w),
              child: SingleChildScrollView(
                child: BlocConsumer<AuthMethodsCubit,AuthMethodsState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return Column(
                      children: [

                        Space(height: 8.h,),

                        SvgPicture.asset(AppImages.login,width: 100.w,height: 20.h,),

                        Space(height: 4.h,),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(LocaleKeys.welcome.tr(), style: AppTheme.heading2TextStyle(),),

                                Space(height: 1.h,),

                                Text(LocaleKeys.chose_a_method.tr(), style: AppTheme.textLTextStyle(),),
                              ],
                            ),
                          ],
                        ),
                        Space(height: 4.h,),

                        MainButton(
                          width: 100.w,height: 7.h,
                          label: Text(
                            LocaleKeys.login.tr(),
                            style: AppTheme.textLTextStyle(color: AppTheme.neutral100),
                          ),
                          onTap: ()=> context.read<AuthMethodsCubit>().onLoginClick(context),
                        ),
                        Space(height: 1.h,),

                        MainButton(
                          width: 100.w,height: 7.h,
                          label: Text(
                            LocaleKeys.register.tr(),
                            style: AppTheme.textLTextStyle(color: AppTheme.neutral100),
                          ),
                          onTap: ()=> context.read<AuthMethodsCubit>().onRegisterClick(context),
                        ),
                        Space(height: 2.h,),

                        CustomDivider(),
                        Space(height: 2.h,),

                        MainButton(
                          borderColor: AppTheme.neutral300,
                          color: AppTheme.neutral100,
                          width: 100.w,height: 7.h,
                          label: (state is AuthMethodsGoogleLoading)?
                          circleIndicator() : googleButtonLable(),
                          onTap: ()=> context.read<AuthMethodsCubit>().onRegisterWithGoogleClick(context),
                        ),
                        Space(height: 2.h,),

                        MainButton(
                          borderColor: AppTheme.neutral300,
                          color: AppTheme.neutral100,
                          width: 100.w,height: 7.h,
                          label: (state is AuthMethodsFacebookLoading)?
                          circleIndicator()
                              : facebookButtonLable(),
                          onTap: ()=> context.read<AuthMethodsCubit>().onRegisterWithFacebookClick(),
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

  Widget googleButtonLable(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center ,
      children: [
        SvgPicture.asset(AppImages.google,width: 6.w,height: 6.w,),
        Space(width: 2.w,),
        Text(LocaleKeys.register_by_google.tr()),
      ],
    );
  }

  Widget facebookButtonLable(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center ,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(AppImages.facebook,width: 6.5.w,height: 6.5.w,),
        Space(width: 2.w,),
        Text(LocaleKeys.register_by_facebook.tr())
      ],
    );
  }

  Widget circleIndicator(){
    return SizedBox(width:8.w,height:8.w,child: CircularProgressIndicator(strokeWidth: .5.w,color: Colors.white,));
  }
}
