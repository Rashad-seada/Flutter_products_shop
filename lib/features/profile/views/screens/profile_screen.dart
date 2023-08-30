import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_images.dart';
import '../../../../core/config/app_theme.dart';
import '../../../../core/views/widgets/clickable_text.dart';
import '../../../../core/views/widgets/custom_back_button.dart';
import '../../../../core/views/widgets/main_button.dart';
import '../../../../core/views/widgets/space.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../auth/views/components/auth_text_field.dart';
import '../../../auth/views/components/phone_number_field.dart';
import '../bloc/profile/profile_cubit.dart';
import '../components/profile/profile_image.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SizedBox(
            width: 100.w,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: SingleChildScrollView(
                child: BlocConsumer<ProfileCubit, ProfileState>(
                  listener: (context, state) {
                  },
                  builder: (context, state) {
                    return Column(
                                  children: [

                                    Space(height: 2.h,),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        CustomBackButton(),

                                        Text(LocaleKeys.profile.tr(), style: AppTheme.heading3TextStyle(),),

                                        Space(width: 5.w,),

                                      ],
                                    ),

                                    Space(height: 5.h,),

                                    ProfileImage(width: 25.w,height: 25.w,),

                                    Space(height: 6.h,),

                                    Form(
                                      key: context.read<ProfileCubit>().profileFormKey,
                                      child: Column(
                                        children: [


                                          AuthTextField(
                                            height: 5.5.h,
                                            validator: (_)=> context.read<ProfileCubit>().validateUsername(),
                                            controller: context.read<ProfileCubit>().nameController,
                                            label: LocaleKeys.name.tr(),hint: LocaleKeys.name_hint.tr(),prefixIcon: Padding(
                                            padding: EdgeInsets.all(1.5.h),
                                            child: SvgPicture.asset(AppImages.profile),
                                          ),
                                          ),
                                          Space(height: 1.5.h,),

                                          AuthTextField(
                                            height: 5.5.h,
                                            validator: (_)=> context.read<ProfileCubit>().validateEmail(),
                                            controller: context.read<ProfileCubit>().emailController,
                                            label: LocaleKeys.email.tr(),hint: LocaleKeys.email_hint.tr(),
                                            prefixIcon: Padding(
                                              padding: EdgeInsets.all(1.5.h),
                                              child: SvgPicture.asset(AppImages.email),
                                            ),
                                          ),

                                          Space(height: 1.5.h,),

                                          PhoneNumberField(
                                            height: 5.7.h,
                                            initialValue:  context.read<ProfileCubit>().initialValue,
                                            controller: context.read<ProfileCubit>().phoneNumberController,
                                            onInputValidated: (bool value) {
                                              context.read<ProfileCubit>().isPhoneNumberValid = value;
                                            },
                                            onInputChanged: (_)=>  context.read<ProfileCubit>().onPhoneChange(_,context),
                                            validator: (_)=> context.read<ProfileCubit>().validatePhoneNumber(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Space(height: 1.5.h,),


                                    Space(height: 16.h,),

                                    ClickableText(
                                      clickableText: LocaleKeys.reset.tr(),
                                      text: "",
                                      style: AppTheme.textMTextStyle(
                                          color: AppTheme.primary900
                                      ),
                                      onPressed: ()=> context.read<ProfileCubit>().onChangePasswordClick(context),
                                    ),
                                    Space(height: 1.5.h,),


                                    MainButton(
                                      width: 100.w,height: 7.h,
                                      label: (state is ProfileLoading)?
                                      SizedBox(width:8.w,height:8.w,child: CircularProgressIndicator(strokeWidth: .5.w,color: Colors.white,))
                                          :Text(
                                        LocaleKeys.save.tr(),
                                        style: AppTheme.textL2TextStyle(color: AppTheme.neutral100),
                                      ),
                                      onTap: ()=> context.read<ProfileCubit>().onSaveClick(context),
                                    ),


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
