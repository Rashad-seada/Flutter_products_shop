import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/features/auth/views/screens/reset_password/password_reset_methods_screen.dart';
import 'package:eng_shop/features/profile/views/screens/profile_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:regexpattern/regexpattern.dart';

import '../../../../../core/config/app_consts.dart';
import '../../../../../core/config/app_images.dart';
import '../../../../../core/di/app_module.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../auth/domain/usecase/logout_usecase.dart';
import '../../../../auth/views/screens/auth_methods_screen.dart';
import '../../../../settings/view/screens/settings_screen.dart';
import '../../components/diaglog.dart';
import '../../util/me_entity.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  PhoneNumber initialValue = PhoneNumber(isoCode: "KW" );
  String phoneNumber = "";

  bool isPhoneNumberValid = false;

  GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();


  ProfileCubit() : super(ProfileInitial());

  String? validateEmail() {
    if (emailController.text.isEmail()) {
      return null;
    } else {
      return "Please enter a valid email";
    }
  }

  String? validateUsername() {
    if (nameController.text.isNotEmpty) {
      return null;
    } else {
      return "Please enter your name";
    }
  }

  validatePhoneNumber() {
    if (isPhoneNumberValid) {
      return null;
    } else {
      return "Please enter a valid phone number";
    }
  }


  onSaveClick(BuildContext context) {

  }


  onPhoneChange(PhoneNumber phoneNumber, BuildContext context) {
    if(initialValue.phoneNumber != null) {
      this.phoneNumber = initialValue.phoneNumber! ;
      phoneNumber = initialValue;
    }
  }

  onChangePasswordClick(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_)=> PasswordResetMethodsScreen()));
  }


  List<MeEntity> get myOrders => [
    MeEntity(label: LocaleKeys.processing.tr(), icon: AppImages.processing),

    MeEntity(label: LocaleKeys.shipped.tr(), icon: AppImages.shipped),

    MeEntity(label: LocaleKeys.returns.tr(), icon: AppImages.returns),

    MeEntity(label: LocaleKeys.tracking.tr(), icon: AppImages.tracking),


  ];


  List<MeEntity> get services => [
    MeEntity(label: LocaleKeys.support.tr(), icon: AppImages.support),

    MeEntity(label: LocaleKeys.survey.tr(), icon: AppImages.survey),

  ];

  onLogoutClick(BuildContext context) {
    showCustomDialog(
        context,
        label: LocaleKeys.logout.tr(),
        message: LocaleKeys.logout_sub_text.tr(),
        callToAction: LocaleKeys.logout.tr(),
        antiCallToAction: LocaleKeys.cancel.tr(),
        onAntiCallToActionTap: (){
          Navigator.pop(context);
        },
        onCallToActionTap: (){
          logout(context);
        }
    );
  }


  logout(BuildContext context) async {
    await getIt<LogoutUsecase>().call(LogoutParams(AppConsts.homeScreen)).then(
            (value) => value.fold(
                (error) {
            },
                (success) {
              return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> const AuthMethodsScreen()), (route) => false);
            }
        )
    );
  }

  onSettengsClick(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (_)=> SettingsScreen()));
  }

  onProfileClick(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_)=> ProfileScreen()));
  }
}
