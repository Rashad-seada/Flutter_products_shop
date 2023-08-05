import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/features/auth/domain/usecase/activate_account_by_sms.dart';
import 'package:eng_shop/features/auth/domain/usecase/register_usecase.dart';
import 'package:eng_shop/features/auth/domain/usecase/validate_email_usecase.dart';
import 'package:eng_shop/features/auth/domain/usecase/validate_phone_usecase.dart';
import 'package:eng_shop/features/auth/views/screens/activation_pin_screen.dart';
import 'package:eng_shop/features/auth/views/screens/login_screen.dart';
import 'package:eng_shop/generated/locale_keys.g.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:regexpattern/regexpattern.dart';
import '../../../../../core/config/app_images.dart';
import '../../../../../core/config/app_strings.dart';
import '../../../../../core/views/screens/message_screen.dart';
import '../../../../../core/views/widgets/custom_flushbar.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(RegistrationInitial());

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController renterPasswordController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  String phoneNumber = "";
  PhoneNumber initPhoneNumber = PhoneNumber(isoCode: "KW" );


  bool isPhoneNumberValid = false;

  bool get doesEmailExist => _doesEmailExist;
  bool get doesPhoneExist => _doesPhoneExist;

  bool _doesEmailExist = false;
  bool _doesPhoneExist = false;

  Timer? validateEmailTimer;
  Timer? validatePhoneTimer;


  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> pinFormKey = GlobalKey<FormState>();

  String? validateEmail(){
    if (emailController.text.isEmail()) {
      return null;
    } else {
      return "Please enter a valid email";
    }
  }

  String? validateUsername(){
    if (userNameController.text.isNotEmpty) {
      return null;
    } else {
      return "Please enter a your name";
    }
  }

  String? validatePhoneNumber(){
    if (isPhoneNumberValid) {
      return null;
    } else {
      return "Please enter a valid phone number";
    }
  }

  String? validatePassword(){
    if (passwordController.text.isPasswordEasy()) {
      return null;
    } else {
      return "Password must be 8 characters";
    }
  }

  String? validateRenterPassword(){
    if (renterPasswordController.text == passwordController.text ) {
      return null;
    } else {
      return "the two password does not match";
    }
  }

  onAlreadyHaveAnAccountClick(BuildContext context) {
    Navigator.pop(context);
  }

  onRegisterClick(BuildContext context) async {
    register(context);
  }

  activateAccountBySms(BuildContext context){
    emit(RegistrationActivatingAccountBySms());
    ActivateAccountBySmsUsecase().call(ActivateAccountBySmsParams(pinController.text, "1234", extractPlusFromPhoneNumber(phoneNumber))).then((value) => value.fold(
            (error) {
              emit(RegistrationInitial());
              CustomFlushBar(
                  title: 'Error!',
                  message: error.message,
                  context: context
              );
            },
            (success) {

              emit(RegistrationInitial());
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => MessageScreen(

                message: LocaleKeys.all_set.tr(),
                messageSubText: LocaleKeys.your_account_active.tr(),
                image: AppImages.done,
                buttonLabel: 'Done',
                screen: LoginScreen(),

              )), (route) => false);
            }
    ));
  }

  register(BuildContext context) async {
    if (registerFormKey.currentState!.validate()) {
      emit(RegistrationLoading());
      await RegisterUsecase().call(RegistrationParams(userNameController.text, emailController.text, passwordController.text,extractPlusFromPhoneNumber(phoneNumber)))
          .then((value) => value.fold(
              (error) {
            emit(RegistrationFailure());
            CustomFlushBar(
                title: 'Error!',
                message: error.message,
                context: context
            );
          },
              (success) {
            emit(RegistrationSuccess());
            CustomFlushBar(
                title: 'Welcome!',
                message: "${success.msg}",
                context: context
            );
            Navigator.push(context,MaterialPageRoute(builder: (_)=> ActivationPinScreen()));
          }
      )
      );
    }
  }

  validateEmailExist(BuildContext context) {
    emit(RegistrationValidatingEmail());
    ValidateEmailUsecase().call(ValidateEmailParams(emailController.text)).then((value) => value.fold(
            (error) {

              _doesEmailExist = false;
              CustomFlushBar(
                  title: 'Email',
                  message: error.message,
                  context: context
              );
              emit(RegistrationInitial());

            },
            (success) {
              if(emailController.text.isEmail()){
                _doesEmailExist = true;
              }
              emit(RegistrationInitial());

            }
    ));
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

  validatePhoneExist(BuildContext context){
    emit(RegistrationValidatingPhone());
    ValidatePhoneUsecase().call(ValidatePhoneParams(extractPlusFromPhoneNumber(phoneNumber))).then((value) => value.fold(
            (error) {
              _doesPhoneExist = false;
              CustomFlushBar(
                  title: 'Phone number',
                  message: error.message,
                  context: context
              );
              emit(RegistrationInitial());

            },
            (success) {

              if(phoneNumber.isPhone()){
                _doesPhoneExist = true;
              }
              emit(RegistrationInitial());

            }
    ));
  }



  onEmailChange(BuildContext context){

    if(validateEmailTimer != null){
      validateEmailTimer!.cancel();
    }

    validateEmailTimer = Timer(Duration(seconds: 2), () {
      validateEmailExist(context);
    });

  }

  onPhoneChange(PhoneNumber number,BuildContext context){
    if(number.phoneNumber != null) {
      phoneNumber = number.phoneNumber!;
    }

    if(validatePhoneTimer != null){
      validatePhoneTimer!.cancel();
    }

    validatePhoneTimer = Timer(Duration(seconds: 2), () {
      validatePhoneExist(context);
    });
  }

  String? pinValidator(String? pin){

  }

  onResendClick(){

  }

  onDoneClick(BuildContext context){
    activateAccountBySms(context);
  }

  onSubmitted(BuildContext context){
    activateAccountBySms(context);
  }


}
