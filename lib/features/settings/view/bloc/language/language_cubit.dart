import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/config/app_consts.dart';
import 'package:eng_shop/core/config/app_images.dart';
import 'package:eng_shop/core/di/app_module.dart';
import 'package:eng_shop/features/auth/domain/usecase/get_user_type_usecase.dart';
import 'package:eng_shop/generated/locale_keys.g.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../settings/data/data_source/local/settings_local_data_source.dart';
import '../../../../shop/views/screens/home_screen.dart';
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
       languageTag = (await getIt<SettingsLocalDataSource>().getLanguage())!;
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
      await getIt<GetUserTypeUsecase>().call(GetUserTypeParams(AppConsts.languageScreen)).then((
          value) => value.fold(
              (error) {

              },
              (success) {
                Timer.periodic(const Duration(seconds: 2), (timer) {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> HomeScreen(userType: success!, context: context,)), (route) => false);
                  emit(LanguageInitial());
                });
              }
          )
      );

    }
  }

}
