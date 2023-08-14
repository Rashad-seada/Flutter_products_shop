import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/config/app_consts.dart';
import 'package:eng_shop/core/config/app_images.dart';
import 'package:eng_shop/core/di/app_module.dart';
import 'package:eng_shop/features/main_feature/views/screens/home_screen.dart';
import 'package:eng_shop/generated/locale_keys.g.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/data_source/local_data_source/settings_local_data_source.dart';
import '../../components/language/language_item.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial());

  int currentLanguage = 0;

  List<LanguageItem> languages = [
    LanguageItem(label: LocaleKeys.arabic.tr(), image: AppImages.arabic, locale: const Locale(AppConsts.arabic),),
    LanguageItem(label: LocaleKeys.english.tr(), image: AppImages.english, locale: const Locale(AppConsts.english),),
  ];

  void initLanguage(BuildContext context)async {
    emit(LanguageChanging());
    late String languageTag;
    try {
       languageTag = await getIt<SettingsLocalDataSource>().getLanguage();
    } catch (e) {
      languageTag = context.deviceLocale.toLanguageTag();
    }
    for(int i = 0; i < languages.length; i++){
      if(languages[i].locale.toLanguageTag() == languageTag) {
        currentLanguage = i;
        languages[i].isActive = true;
      }
    }
    emit(LanguageInitial());
  }

  void onLanguageClick(index,BuildContext context) async {
    if(currentLanguage != index){
      emit(LanguageChanging());

      getIt<SettingsLocalDataSource>().putLanguage(languages[index].locale.toLanguageTag());
      languages[currentLanguage].isActive = false;
      languages[index].isActive = true;
      currentLanguage = index;
      await  context.setLocale(languages[index].locale);
      Timer.periodic(const Duration(seconds: 2), (timer) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> HomeScreen()), (route) => false);
        emit(LanguageInitial());
      });
    }
  }

}
