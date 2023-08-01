import 'package:bloc/bloc.dart';
import 'package:eng_shop/core/config/app_images.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:regexpattern/regexpattern.dart';

import '../../../../../core/config/app_strings.dart';
import '../../../../../core/views/screens/message_screen.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  TextEditingController emailController = TextEditingController();

  String phoneNumber = "";
  bool isPhoneNumberValid = false;

  GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();

  String? validateEmail() {
    if(emailController.text.isEmail()) {
      return null;
    }else {
      return "please enter a valid email";
    }
  }

  String? validatePhoneNumber() {
    if(isPhoneNumberValid) {
      return null;
    }else {
      return "please enter a valid phone number";
    }
  }

  sendCodeToPhoneNumber(){

  }

  sendCodeToEmail(BuildContext context){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> MessageScreen(
      message: AppStrings.checkEmail,
      messageSubText: AppStrings.checkEmailSubtitle,
      image: AppImages.letter,
      buttonLabel: 'Done',
    )), (route) => false);
  }

  onResetPasswordClick(BuildContext context) async {
    if(resetPasswordFormKey.currentState!.validate()) {

      if(emailController.text.isEmail()) {
        sendCodeToEmail(context);
      }else {
        sendCodeToPhoneNumber();
      }
    }
  }


}
