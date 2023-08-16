import 'package:bloc/bloc.dart';
import 'package:eng_shop/core/config/app_consts.dart';
import 'package:eng_shop/core/di/app_module.dart';
import 'package:eng_shop/features/auth/domain/usecase/login_uscase.dart';
import 'package:eng_shop/features/auth/views/screens/registration_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:regexpattern/regexpattern.dart';

import '../../../../../core/views/widgets/custom_flushbar.dart';
import '../../../../main_feature/views/screens/home_screen.dart';
import '../../../domain/usecase/get_user_type_usecase.dart';
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
    if (emailController.text.isEmail() || emailController.text.isPhone() || emailController.text.isUsername()) {
      return null;
    } else {
      return "Please enter a valid email or number";
    }
  }

  bool isMobile(){
    if(emailController.text.isPhone()) {
      return true;
    }
    return false;
  }

  login(BuildContext context){
    if(loginFormKey.currentState!.validate()){
      emit(LoginLoading());
      getIt<LoginUsecase>().call(LoginParams(emailController.text,passwordController.text,isMobile(),AppConsts.loginScreen)).then(
        (value) => value.fold(
          (error) {
            emit(LoginFailure());
            CustomFlushBar(
                title: 'Error : ${error.code()}',
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
            Navigator.push(context,MaterialPageRoute(builder: (_)=> HomeScreen(userType: success.utype!,)));
          })
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

  Future<void> getUserType(BuildContext context) async {
    await getIt<GetUserTypeUsecase>().call(GetUserTypeParams(AppConsts.introScreen)).then(
            (value) => value.fold(
                (error) {
              print(error.toString());
            },
                (success) {
              print("user type is $success");

            }
        ));
  }

}


