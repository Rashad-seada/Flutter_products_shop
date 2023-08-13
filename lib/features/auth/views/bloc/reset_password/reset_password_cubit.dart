
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/features/auth/domain/usecase/reset_password_usecase.dart';
import 'package:eng_shop/features/auth/domain/usecase/send_sms_usecase.dart';
import 'package:eng_shop/features/auth/domain/usecase/validate_code_usecase.dart';
import 'package:eng_shop/features/auth/views/screens/login_screen.dart';
import 'package:eng_shop/features/auth/views/screens/new_password_screen.dart';
import 'package:eng_shop/features/auth/views/screens/pin_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:regexpattern/regexpattern.dart';

import '../../../../../core/config/app_consts.dart';
import '../../../../../core/config/app_images.dart';
import '../../../../../core/di/app_module.dart';
import '../../../../../core/views/screens/message_screen.dart';
import '../../../../../core/views/widgets/custom_flushbar.dart';
import '../../../../../generated/locale_keys.g.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  TextEditingController emailController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController renterPasswordController = TextEditingController();

  bool isPhoneNumberValid = false;
  PhoneNumber initPhoneNumber = PhoneNumber(isoCode: "KW");

  GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> pinFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> newPasswordFormKey = GlobalKey<FormState>();

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

  sendCodeToPhoneNumber(BuildContext context) async {
    emit(ResetPasswordLoading());
    await getIt<SendSmsUsecase>().call(SendSmsParams(extractPlusFromPhoneNumber(initPhoneNumber.phoneNumber!),AppConsts.resetPasswordMethodScreen)).then(
            (value) => value.fold(
                (error) {
              emit(ResetPasswordFailure());
              CustomFlushBar(
                  title: 'Error',
                  message: error.message,
                  context: context
              );
            },
                (success) {
              emit(ResetPasswordSuccess());
              Navigator.push(context,MaterialPageRoute(builder: (_)=> PinScreen()));
            }
        )
    );
  }

  sendCodeToEmail(BuildContext context) async {

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

  onDoneClick(BuildContext context) async {
    emit(ResetPasswordLoading());
    await getIt<ValidateCodeUsecase>().call(ValidateCodeParams(extractPlusFromPhoneNumber(initPhoneNumber.phoneNumber!), pinController.text,AppConsts.pinScreen)).then(
            (value) => value.fold(
                    (error) {
                      emit(ResetPasswordFailure());
                      CustomFlushBar(
                          title: 'Error',
                          message: error.message,
                          context: context
                      );
                    },
                    (success) {
                      emit(ResetPasswordSuccess());
                      Navigator.push(context,MaterialPageRoute(builder: (_)=> NewPasswordScreen()));
                    }
            )
    );
  }

  onResendClick(BuildContext context) async {
    emit(ResetPasswordResendSmsLoading());
    await getIt<SendSmsUsecase>().call(SendSmsParams(extractPlusFromPhoneNumber(initPhoneNumber.phoneNumber!),AppConsts.pinScreen)).then(
            (value) => value.fold(
                (error) {
              emit(ResetPasswordFailure());
              CustomFlushBar(
                  title: 'Error',
                  message: error.message,
                  context: context
              );
            },
                (success) {
              emit(ResetPasswordSuccess());
            }
        )
    );
  }

  String? pinValidator(String? pin){

  }

  validatePin(){
  }

  onSubmittedPin(String pin,BuildContext context){
    onDoneClick(context);
  }

  String extractPlusFromPhoneNumber(String number){
    List numberInList = number.split("");
    for(int i = 0; i < numberInList.length; ++i ){
      if(numberInList[i] == "+"){
        numberInList.removeAt(i);
        return numberInList.join();
      }
    }
    return number;
  }

  String? validatePassword() {
    if(passwordController.text.isPasswordEasy()) {
      return null;
    }else {
      return "please enter a valid password";
    }
  }

  String? validateRenterPassword() {
    if(passwordController.text == renterPasswordController.text) {
      return null;
    }else {
      return "the two passwords must match";
    }
  }

  onNewPasswordClick(BuildContext context) async {
    if(newPasswordFormKey.currentState!.validate()){
      emit(ResetPasswordLoading());
      await getIt<ResetPasswordUsecase>().call(ResetPasswordParams(extractPlusFromPhoneNumber(initPhoneNumber.phoneNumber!), pinController.text, passwordController.text,AppConsts.newPasswordScreen)).then(
              (value) => value.fold(
              (error) {
                emit(ResetPasswordFailure());
                CustomFlushBar(
                    title: 'Error',
                    message: error.message,
                    context: context
                );
              },
              (success) {
                emit(ResetPasswordSuccess());
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => MessageScreen(
                  message: LocaleKeys.check_email.tr(),
                  messageSubText: LocaleKeys.check_email_subtitle.tr(),
                  image: AppImages.done,
                  buttonLabel: LocaleKeys.done.tr(),
                  screen: LoginScreen(),

                )), (route) => false);
              }
          )
      );
    }

  }




}
