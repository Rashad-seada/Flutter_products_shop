import 'package:bloc/bloc.dart';
import 'package:eng_shop/core/infrastructure/services/services.dart';
import 'package:eng_shop/features/auth/views/screens/login/login_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/di/app_module.dart';
import '../../screens/registration/registration_screen.dart';

part 'auth_methods_state.dart';

class AuthMethodsCubit extends Cubit<AuthMethodsState> {

  AuthMethodsCubit() : super(AuthMethodsInitial());

  onLoginClick(BuildContext context){
    Navigator.push(context,MaterialPageRoute(builder: (_)=> LoginScreen()));
  }

  onRegisterClick(BuildContext context){
    Navigator.push(context,MaterialPageRoute(builder: (_)=> RegistrationScreen()));
  }

  onRegisterWithGoogleClick(BuildContext context){
    _registerWithGoogle(context);
  }

  onRegisterWithFacebookClick(BuildContext context){
    _registerWithFacebook(context);
  }

  _registerWithGoogle(BuildContext context) async {
    await getIt<Services>().googleService.getGoogleAccount().then(
      (account) {
        Navigator.push(context,MaterialPageRoute(builder: (_)=> RegistrationScreen(email: account?.email ?? "",name: account?.displayName ?? "",)));
        getIt<Services>().googleService.signOut();
      }
    );
  }

  _registerWithFacebook(BuildContext context) async {
    await getIt<Services>().facebookService.login().then(
    (account) {
    //Navigator.push(context,MaterialPageRoute(builder: (_)=> RegistrationScreen(email: account?.email ?? "",name: account?.displayName ?? "",)));

      print(account);
    getIt<Services>().facebookService.logOut();
    }
    );
  }

}
