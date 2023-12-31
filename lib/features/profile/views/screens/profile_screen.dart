import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/views/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_images.dart';
import '../../../../core/config/app_theme.dart';
import '../../../../core/views/widgets/clickable_text.dart';
import '../../../../core/views/widgets/custom_back_button.dart';
import '../../../../core/views/widgets/custom_flushbar.dart';
import '../../../../core/views/widgets/main_button.dart';
import '../../../../core/views/widgets/space.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../auth/views/components/auth_text_field.dart';
import '../bloc/profile/profile_cubit.dart';
import '../components/profile/profile_image.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    context.read<ProfileCubit>().getProfile();
    super.initState();
  }

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

                    if(state is ProfileFailure){
                      CustomFlushBar(
                          title: 'Error : ${ProfileFailure.myFailure.code()}',
                          message: ProfileFailure.myFailure.message,
                          context: context
                      );
                    }

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
                                            validator: (_)=> context.read<ProfileCubit>().validateUsername(),
                                            controller: context.read<ProfileCubit>().nameController,
                                            label: LocaleKeys.name.tr(),hint: LocaleKeys.name_hint.tr(),prefixIcon: Padding(
                                            padding: EdgeInsets.all(1.5.h),
                                            child: SvgPicture.asset(AppImages.profile),
                                          ),
                                          ),



                                        ],
                                      ),
                                    ),


                                    Space(height: 35.h,),

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
                                      CustomProgressIndicator(color: AppTheme.neutral100,) :Text(
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
        )
    );
  }
}
