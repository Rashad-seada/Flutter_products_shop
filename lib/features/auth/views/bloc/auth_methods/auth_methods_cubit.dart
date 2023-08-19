import 'package:bloc/bloc.dart';
import 'package:eng_shop/core/services/services.dart';
import 'package:eng_shop/features/auth/views/screens/login/login_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../screens/registration/registration_screen.dart';

part 'auth_methods_state.dart';

class AuthMethodsCubit extends Cubit<AuthMethodsState> {

  AuthMethodsCubit() : super(AuthMethodsInitial());
  final Services services = Services();

  onLoginClick(BuildContext context){
    Navigator.push(context,MaterialPageRoute(builder: (_)=> LoginScreen()));
  }

  onRegisterClick(BuildContext context){
    Navigator.push(context,MaterialPageRoute(builder: (_)=> RegistrationScreen()));
  }

  onRegisterWithGoogleClick(BuildContext context){
    _registerWithGoogle(context);
  }

  onRegisterWithFacebookClick(){
    _registerWithFacebook();
  }

  _registerWithGoogle(BuildContext context) async {
    await services.googleService.getGoogleAccount().then(
            (account) {
              Navigator.push(context,MaterialPageRoute(builder: (_)=> RegistrationScreen(email: account?.email ?? "",name: account?.displayName ?? "",)));
            }
    );
  }

  _registerWithFacebook(){

  }

}
