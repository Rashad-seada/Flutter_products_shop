import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberMe = true;

  onLoginClick(){}

  onResetPasswordClick(){}

  onDontHaveAnAccountClick(){}


  LoginCubit() : super(LoginInitial());
}


