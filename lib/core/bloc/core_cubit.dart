import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/config/app_consts.dart';
import 'package:eng_shop/features/auth/domain/usecase/get_user_type_usecase.dart';
import 'package:eng_shop/features/main_feature/views/screens/home_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../features/auth/data/data_source/local_data_source/auth_local_data_source.dart';
import '../../features/auth/views/screens/auth_methods_screen.dart';
import '../../firebase_options.dart';
import '../di/app_module.dart';

part 'core_state.dart';

class CoreCubit extends Cubit<CoreState> {



  init() async {
    await AppModule.setupDependencies();


    await EasyLocalization.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    if(await getIt<AuthLocalDataSource>().getIsSignedIn() == null) {
      await getIt<AuthLocalDataSource>().putIsSignedIn(1);
    }

  }

  Future<void> getUserType(BuildContext context) async {
    await getIt<GetUserTypeUsecase>().call(GetUserTypeParams(AppConsts.introScreen)).then(
            (value) => value.fold(
                    (error) {
                      print(error.message);

                      timer(AuthMethodsScreen(),context);


                    },
                    (success) {
                      if (success == null) {
                        timer(AuthMethodsScreen(),context);

                      }else {
                        timer(HomeScreen( userType: success,),context,);

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
