import 'package:bloc/bloc.dart';
import 'package:eng_shop/features/auth/views/screens/password_reset_methods_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:regexpattern/regexpattern.dart';

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
}
