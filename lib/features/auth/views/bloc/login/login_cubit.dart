import 'package:bloc/bloc.dart';
import 'package:eng_shop/features/auth/domain/usecase/login_uscase.dart';
import 'package:eng_shop/features/auth/views/screens/registration_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:regexpattern/regexpattern.dart';

import '../../../../../core/views/widgets/custom_flushbar.dart';
import '../../screens/password_reset_methods_screen.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberMe = true;

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  onLoginClick(BuildContext context){
    login(context);
  }

  String? validatePassword(){
    if (passwordController.text.isPasswordEasy()) {
      return null;
    } else {
      return "Password must be 8 characters";
    }
  }

  String? validateEmail(){
    if (emailController.text.isEmail()) {
      return null;
    } else {
      return "Please enter a valid email";
    }
  }

  login(BuildContext context){
    if(loginFormKey.currentState!.validate()){
      emit(LoginLoading());

      LoginUsecase().call(LoginParams(emailController.text,passwordController.text)).then(
              (value) => value.fold(
                  (error) {
                emit(LoginFailure());
                CustomFlushBar(
                    title: 'Error!',
                    message: error.message,
                    context: context
                );
              },
                  (success) {
                emit(LoginSuccess());
                CustomFlushBar(
                    title: 'Welcome',
                    message: success.msg!,
                    context: context
                );
              }
          )
      );
    }
  }

  onResetPasswordClick(BuildContext context){
    Navigator.push(context,MaterialPageRoute(builder: (_)=> const PasswordResetMethodsScreen()));
  }

  onDontHaveAnAccountClick(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (_)=> RegistrationScreen()));
  }


  LoginCubit() : super(LoginInitial());

}


