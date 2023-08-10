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

part 'core_state.dart';

class CoreCubit extends Cubit<CoreState> {

  final AuthLocalDataSource _authLocalDataSource = AuthLocalDataSourceImpl();
  final SettingsLocalDataSource _mainLocalDataSource = SettingsLocalDataSourceImpl();

  _seedingInitialValue() async {
    await _mainLocalDataSource.putServiceProviderDomain(AppConsts.domain);
    await _mainLocalDataSource.putServiceProviderEmail(AppConsts.serviceEmail);
    await _mainLocalDataSource.putServiceProviderPassword(AppConsts.servicePassword);
  }

  init() async {
    await EasyLocalization.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    if(await _authLocalDataSource.getIsFirstTime() == null) {
      await _seedingInitialValue();
      await _authLocalDataSource.putIsFirstTime(1);
    }
  }


  CoreCubit() : super(CoreInitial());
}
