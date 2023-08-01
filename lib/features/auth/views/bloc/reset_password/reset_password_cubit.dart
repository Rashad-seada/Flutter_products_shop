import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:regexpattern/regexpattern.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  TextEditingController emailController = TextEditingController();

  String phoneNumber = "";

  GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();

  String? validateEmailOrPhoneNumber() {
    if(emailController.text.isEmail() || emailController.text.isPhone()) {
      return null;
    }else {
      return "please enter a valid email or phone number";
    }
  }

  sendCodeToPhoneNumber(){}

  sendCodeToEmail(){}

  onResetPasswordClick() async {
    if(resetPasswordFormKey.currentState!.validate()) {

      if(emailController.text.isEmail()) {
        sendCodeToEmail();
      }else {
        sendCodeToPhoneNumber();
      }
    }
  }


}
