import 'package:bloc/bloc.dart';
import 'package:eng_shop/features/auth/views/screens/registration_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../screens/password_reset_methods_screen.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberMe = true;

  onLoginClick(){

  }

  onResetPasswordClick(BuildContext context){
    Navigator.push(context,MaterialPageRoute(builder: (_)=> const PasswordResetMethodsScreen()));
  }

  onDontHaveAnAccountClick(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (_)=> RegistrationScreen()));
  }


  LoginCubit() : super(LoginInitial());

}


