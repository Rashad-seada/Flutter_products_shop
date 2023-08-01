import 'package:bloc/bloc.dart';
import 'package:eng_shop/features/auth/domain/usecase/register_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:regexpattern/regexpattern.dart';

import '../../../../../core/views/widgets/custom_flushbar.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(RegistrationInitial());

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String phoneNumber = "";
  TextEditingController passwordController = TextEditingController();
  TextEditingController renterPasswordController = TextEditingController();

  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

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
    print(phoneNumber);////////////////////
    if (phoneNumber.isPhone()) {
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

  onRegisterClick(BuildContext context)async {
    if (registerFormKey.currentState!.validate()) {
      emit(RegistrationLoading());
      await RegisterUsecase().call(RegistrationParams(userNameController.text, emailController.text, passwordController.text,phoneNumber))
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
          }
      )
      );
    }
  }

}
