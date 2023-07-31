import 'package:another_flushbar/flushbar.dart';
import 'package:bloc/bloc.dart';
import 'package:eng_shop/features/auth/domain/usecase/register_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/config/app_theme.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(RegistrationInitial());

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController renterPasswordController = TextEditingController();

  onAlreadyHaveAnAccountClick(BuildContext context) {
    Navigator.pop(context);

  }

  onRegisterClick(BuildContext context)async {
    emit(RegistrationLoading());
    await RegisterUsecase().call(RegistrationParams(userNameController.text, emailController.text, passwordController.text,phoneNumberController.text))
        .then((value) => value.fold(
            (error) {
              emit(RegistrationFailure());
              Flushbar(
                backgroundColor: AppTheme.primary,
                title: 'Welcome',
                message:
                'you just logged in to your account, have fun!',
                duration: Duration(seconds: 3),
              ).show(context);
            },
            (success) {
              emit(RegistrationSuccess());
              Flushbar(
                backgroundColor: AppTheme.primary,
                title: 'Welcome',
                message:
                'you just logged in to your account, have fun!',
                duration: Duration(seconds: 3),
              ).show(context);
            }
    )
    );
  }

}
