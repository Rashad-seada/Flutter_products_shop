import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/config/app_consts.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../features/auth/data/data_source/local_data_source/auth_local_data_source.dart';
import '../../features/main_feature/data/data_source/local_data_source/settings_local_data_source.dart';
import '../../firebase_options.dart';
import '../di/app_module.dart';

part 'core_state.dart';

class CoreCubit extends Cubit<CoreState> {

  _seedingInitialValue() async {
    await getIt<SettingsLocalDataSource>().putServiceProviderDomain(AppConsts.domain);
    await getIt<SettingsLocalDataSource>().putServiceProviderEmail(AppConsts.serviceEmail);
    await getIt<SettingsLocalDataSource>().putServiceProviderPassword(AppConsts.servicePassword);
  }

  init() async {
    AppModule.setupDependencies();

    await EasyLocalization.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    if(await getIt<AuthLocalDataSource>().getIsFirstTime() == null) {
      await _seedingInitialValue();
      await getIt<AuthLocalDataSource>().putIsFirstTime(1);
    }

  }


  CoreCubit() : super(CoreInitial());
}
