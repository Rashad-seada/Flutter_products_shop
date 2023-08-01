
import 'package:eng_shop/features/auth/views/bloc/registration/registration_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_images.dart';
import '../../../../core/config/app_strings.dart';
import '../../../../core/config/app_theme.dart';
import '../../../../core/views/widgets/auth_text_field.dart';
import '../../../../core/views/widgets/clickable_text.dart';
import '../../../../core/views/widgets/main_button.dart';
import '../../../../core/views/widgets/phone_number_field.dart';
import '../../../../core/views/widgets/space.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SizedBox(
            width: 100.w,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.w),
              child: BlocConsumer<RegistrationCubit, RegistrationState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return SingleChildScrollView(
                    child: Column(children: [

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
                              Text(AppStrings.register, style: AppTheme.heading2TextStyle(),),

                              Space(height: 1.h,),

                              Text(AppStrings.registerSubTitle, style: AppTheme.textLTextStyle(),),
                            ],
                          ),
                        ],
                      ),

                      Space(height: 3.5.h,),

                      Form(
                          key: context.read<RegistrationCubit>().registerFormKey,
                          child: Column(
                          children: [
                            AuthTextField(
                              validator: (_)=> context.read<RegistrationCubit>().validateUsername(),
                              controller: context.read<RegistrationCubit>().userNameController,
                                label: AppStrings.name,hint: AppStrings.nameHint,prefixIcon: Padding(
                                padding: EdgeInsets.all(1.5.h),
                                child: SvgPicture.asset(AppImages.profile),
                              ),
                            ),
                            Space(height: 1.5.h,),

                            AuthTextField(
                              validator: (_)=> context.read<RegistrationCubit>().validateEmail(),
                              controller: context.read<RegistrationCubit>().emailController,
                              label: AppStrings.email,hint: AppStrings.emailHint,prefixIcon: Padding(
                              padding: EdgeInsets.all(1.5.h),
                              child: SvgPicture.asset(AppImages.email),
                            ),),
                            Space(height: 1.5.h,),

                            PhoneNumberField(
                              onInputChanged: (PhoneNumber number) {
                                print(number);
                                if(number.phoneNumber != null){
                                  context.read<RegistrationCubit>().phoneNumber = number.phoneNumber!;
                                }
                              },
                              validator: (_)=> context.read<RegistrationCubit>().validatePhoneNumber(),
                            ),
                            Space(height: 1.5.h,),

                            AuthTextField(
                              validator: (_)=> context.read<RegistrationCubit>().validatePassword(),
                              controller: context.read<RegistrationCubit>().passwordController,
                              label: AppStrings.password,hint: AppStrings.passwordHint,prefixIcon: Padding(
                              padding: EdgeInsets.all(1.5.h),
                              child: SvgPicture.asset(AppImages.lock),
                            ),),
                            Space(height: 1.5.h,),

                            AuthTextField(
                              validator: (_)=> context.read<RegistrationCubit>().validateRenterPassword(),
                              controller: context.read<RegistrationCubit>().renterPasswordController,
                              label: AppStrings.renterPassword,hint: AppStrings.renterPasswordHint,prefixIcon: Padding(
                              padding: EdgeInsets.all(1.5.h),
                              child: SvgPicture.asset(AppImages.lock),
                            ),),
                          ],
                      )),

                      Space(height: 10.h,),


                      ClickableText(
                        clickableText: AppStrings.register,
                        text: AppStrings.dontHaveAnAccount,
                        style: AppTheme.textMTextStyle(
                            color: AppTheme.primary
                        ),
                        onPressed: ()=> context.read<RegistrationCubit>().onAlreadyHaveAnAccountClick(context),
                      ),
                      Space(height: 1.h,),


                      MainButton(
                        width: 100.w,height: 7.h,
                        label: (state is RegistrationLoading)?
                        SizedBox(width:8.w,height:8.w,child: CircularProgressIndicator(strokeWidth: .5.w,color: Colors.white,))
                        :Text(
                          AppStrings.register,
                          style: AppTheme.textLTextStyle(color: AppTheme.neutral100),
                        ),
                        onTap: ()=> context.read<RegistrationCubit>().onRegisterClick(context),
                      )


                    ],),
                  );
                },
              ),
            ),
          ),
        )
    );
  }
}
