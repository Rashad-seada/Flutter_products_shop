import 'package:bloc/bloc.dart';
import 'package:eng_shop/core/config/app_images.dart';
import 'package:eng_shop/features/auth/views/screens/pin_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:regexpattern/regexpattern.dart';

import '../../../../../core/config/app_strings.dart';
import '../../../../../core/views/screens/message_screen.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  TextEditingController emailController = TextEditingController();

  bool isPhoneNumberValid = false;
  PhoneNumber initPhoneNumber = PhoneNumber(isoCode: "KW");

  GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> pinFormKey = GlobalKey<FormState>();

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

  sendCodeToPhoneNumber(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (_) => PinScreen()));
  }

  sendCodeToEmail(BuildContext context){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => MessageScreen(
      message: AppStrings.checkEmail,
      messageSubText: AppStrings.checkEmailSubtitle,
      image: AppImages.letter,
      buttonLabel: 'Done',
      screen: PinScreen(),

    )), (route) => false);
  }

  onResetPasswordClick(BuildContext context) async {

    if(resetPasswordFormKey.currentState!.validate()) {

      if(emailController.text.isEmail()) {
        sendCodeToEmail(context);
      }else if(isPhoneNumberValid){
        sendCodeToPhoneNumber(context);
      }
    }
  }


  onInputValidated(bool valid){
    isPhoneNumberValid = valid;

  }

  onInputChange(PhoneNumber number){
    if (number.phoneNumber != null){
      initPhoneNumber = number;
    }
  }

  onDoneClick(){

  }

  onResendClick(){

  }

  String? pinValidator(String? pin){

  }

  validatePin(){

  }

  onSubmittedPin(String pin){

    validatePin();
  }


}
