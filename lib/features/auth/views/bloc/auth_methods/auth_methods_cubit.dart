import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_methods_state.dart';

class AuthMethodsCubit extends Cubit<AuthMethodsState> {

  AuthMethodsCubit() : super(AuthMethodsInitial());

  onLoginClick(){

  }

  onRegisterClick(){

  }

  onRegisterWithGoogleClick(){
    _registerWithGoogle();
  }

  onRegisterWithFacebookClick(){
    _registerWithFacebook();
  }

  _registerWithGoogle(){

  }

  _registerWithFacebook(){

  }

}
