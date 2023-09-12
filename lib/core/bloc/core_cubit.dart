import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../features/auth/data/data_source/local_data_source/auth_local_data_source.dart';
import '../../features/auth/domain/usecase/get_user_type_usecase.dart';
import '../../features/auth/views/screens/auth_methods_screen.dart';
import '../../features/shop/views/screens/home_screen.dart';
import '../config/app_consts.dart';
import '../di/app_module.dart';

part 'core_state.dart';

class CoreCubit extends Cubit<CoreState> {


  init() async {
    await AppModule.setupDependencies();


    await EasyLocalization.ensureInitialized();

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    if(await getIt<AuthLocalDataSource>().getIsSignedIn() == null) {
      await getIt<AuthLocalDataSource>().putIsSignedIn(1);
    }

  }

  Future<void> getUserType(BuildContext context) async {
    await getIt<GetUserTypeUsecase>().call(GetUserTypeParams(AppConsts.introScreen)).then(
            (value) => value.fold(
                    (error) {

                      timer(AuthMethodsScreen(),context);


                    },
                    (success) {
                      if (success == null) {
                        timer(AuthMethodsScreen(),context);

                      }else {
                        timer(HomeScreen( userType: success, context: context),context,);

                      }
                    }
            ));
  }

  timer(Widget screen,BuildContext context){
    Timer.periodic(const Duration(seconds: 3), (timer) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (_) => screen
          ), (route) => false
      );
    });
  }


  CoreCubit() : super(CoreInitial());
}
