import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/config/app_strings.dart';
import 'package:eng_shop/core/views/widgets/clickable_text.dart';
import 'package:eng_shop/features/auth/views/bloc/registration/registration_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/config/app_theme.dart';
import '../../../../../core/views/widgets/custom_back_button.dart';
import '../../../../../core/views/widgets/main_button.dart';
import '../../../../../core/views/widgets/space.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../components/pin_field.dart';

class ActivationPinScreen extends StatelessWidget {

  ActivationPinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SizedBox(
            width: 100.w,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: SingleChildScrollView(
                child: BlocConsumer<RegistrationCubit, RegistrationState>(
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

                            Text(LocaleKeys.verification_sub_text.tr(), style: AppTheme.textL2TextStyle(),textAlign: TextAlign.center,),
                          ],
                        ),
                        Space(height: 5.h,),

                        Form(
                          key: context.read<RegistrationCubit>().pinFormKey,
                          child: PinField(
                            controller: context.read<RegistrationCubit>().pinController,
                            validator: (_)=> context.read<RegistrationCubit>().pinValidator(_),
                          ),
                        ),
                        Space(height: 2.h,),

                        ClickableText(
                          onPressed: ()=> context.read<RegistrationCubit>().onResendClick(),
                          clickableText: LocaleKeys.resend.tr(),
                          text: LocaleKeys.didnt_receive_code.tr(),
                          style: AppTheme.textL2TextStyle(color: AppTheme.primary900),
                        ),
                        Space(height: 42.h,),

                        MainButton(
                          width: 100.w,height: 7.h,
                          label: (state is RegistrationActivatingAccountBySms)?
                          SizedBox(width:8.w,height:8.w,child: CircularProgressIndicator(strokeWidth: .5.w,color: Colors.white,))
                              :Text(
                            LocaleKeys.done.tr(),
                            style: AppTheme.textL2TextStyle(color: AppTheme.neutral100),
                          ),
                          onTap: ()=> context.read<RegistrationCubit>().onDoneClick(context),
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
