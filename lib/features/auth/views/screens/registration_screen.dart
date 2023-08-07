
import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/features/auth/views/bloc/registration/registration_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_images.dart';
import '../../../../core/config/app_strings.dart';
import '../../../../core/config/app_theme.dart';
import '../../../../core/views/widgets/custom_back_button.dart';
import '../../../../generated/locale_keys.g.dart';
import '../components/auth_text_field.dart';
import '../../../../core/views/widgets/clickable_text.dart';
import '../../../../core/views/widgets/main_button.dart';
import '../components/phone_number_field.dart';
import '../../../../core/views/widgets/space.dart';

class RegistrationScreen extends StatefulWidget {
  String email;
  String name;

  RegistrationScreen({super.key,this.email = "",this.name= ""});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  @override
  void initState() {
    context.read<RegistrationCubit>().emailController.text = widget.email;
    context.read<RegistrationCubit>().userNameController.text = widget.name;
    super.initState();
  }

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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomBackButton(),

                          Image.asset(AppImages.logo,width: 14.w,height: 14.w,)
                        ],
                      ),

                      Space(height: 5.h,),

                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(LocaleKeys.register.tr(), style: AppTheme.heading2TextStyle(),),

                              Space(height: 1.h,),

                              Text(LocaleKeys.register_sub_title.tr(), style: AppTheme.textLTextStyle(),),
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
                                label: LocaleKeys.name.tr(),hint: LocaleKeys.name_hint.tr(),prefixIcon: Padding(
                                padding: EdgeInsets.all(1.5.h),
                                child: SvgPicture.asset(AppImages.profile),
                              ),
                            ),
                            Space(height: 1.5.h,),

                            AuthTextField(
                              onChanged: (_)=> context.read<RegistrationCubit>().onEmailChange(context),
                              validator: (_)=> context.read<RegistrationCubit>().validateEmail(),
                              controller: context.read<RegistrationCubit>().emailController,
                              label: LocaleKeys.email.tr(),hint: LocaleKeys.email_hint.tr(),
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(1.5.h),
                                child: SvgPicture.asset(AppImages.email),
                              ),
                              suffixIcon: (state is RegistrationValidatingEmail)? circleIndicator() : checkMark(context.read<RegistrationCubit>().doesEmailExist),
                            ),
                            Space(height: 1.5.h,),

                            PhoneNumberField(
                              suffixIcon: (state is RegistrationValidatingPhone)? circleIndicator() : checkMark(context.read<RegistrationCubit>().doesPhoneExist),
                              initialValue:  context.read<RegistrationCubit>().initPhoneNumber,
                              controller: context.read<RegistrationCubit>().phoneNumberController,
                              onInputValidated: (bool value) {
                                context.read<RegistrationCubit>().isPhoneNumberValid = value;
                              },
                              onInputChanged: (_)=>  context.read<RegistrationCubit>().onPhoneChange(_,context),
                              validator: (_)=> context.read<RegistrationCubit>().validatePhoneNumber(),
                            ),
                            Space(height: 1.5.h,),

                            AuthTextField(
                              validator: (_)=> context.read<RegistrationCubit>().validatePassword(),
                              controller: context.read<RegistrationCubit>().passwordController,
                              label: LocaleKeys.password.tr(),hint: LocaleKeys.password_hint.tr(),prefixIcon: Padding(
                              padding: EdgeInsets.all(1.5.h),
                              child: SvgPicture.asset(AppImages.lock),
                            ),),
                            Space(height: 1.5.h,),

                            AuthTextField(
                              validator: (_)=> context.read<RegistrationCubit>().validateRenterPassword(),
                              controller: context.read<RegistrationCubit>().renterPasswordController,
                              label: LocaleKeys.renter_password.tr(),hint: LocaleKeys.renter_password_hint.tr(),prefixIcon: Padding(
                              padding: EdgeInsets.all(1.5.h),
                              child: SvgPicture.asset(AppImages.lock),
                            ),),
                          ],
                      )),

                      Space(height: 7.h,),


                      ClickableText(
                        clickableText: LocaleKeys.register.tr(),
                        text: LocaleKeys.dont_have_an_account.tr(),
                        style: AppTheme.textMTextStyle(
                            color: AppTheme.primary900
                        ),
                        onPressed: ()=> context.read<RegistrationCubit>().onAlreadyHaveAnAccountClick(context),
                      ),
                      Space(height: .5.h,),


                      MainButton(
                        width: 100.w,height: 7.h,
                        label: (state is RegistrationLoading)?
                        SizedBox(width:8.w,height:8.w,child: CircularProgressIndicator(strokeWidth: .5.w,color: Colors.white,))
                        :Text(
                          LocaleKeys.register.tr(),
                          style: AppTheme.textLTextStyle(color: AppTheme.neutral100),
                        ),
                        onTap: ()=> context.read<RegistrationCubit>().onRegisterClick(context),
                      ),


                    ],),
                  );
                },
              ),
            ),
          ),
        )
    );


  }

  Widget checkMark(bool isChecked){
    if (isChecked) {
      return Icon(Icons.done,color: AppTheme.success,);
    }
    return Icon(Icons.cancel_outlined,color: AppTheme.error,);
  }

  Widget circleIndicator(){
    return  Padding(
      padding: EdgeInsets.all(3.w),
      child: SizedBox(width:4.w,height:4.w,child: CircularProgressIndicator(strokeWidth: .5.w,color: AppTheme.neutral800,)),
    );
  }
}
