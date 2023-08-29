import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/config/app_images.dart';
import 'package:eng_shop/generated/locale_keys.g.dart';
import 'package:equatable/equatable.dart';

import '../../util/me_entity.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  List<MeEntity> myOrders = [
    MeEntity(label: LocaleKeys.support.tr(), icon: AppImages.support),

    MeEntity(label: LocaleKeys.survey.tr(), icon: AppImages.survey),

    MeEntity(label: LocaleKeys.support.tr(), icon: AppImages.support),

    MeEntity(label: LocaleKeys.survey.tr(), icon: AppImages.survey),
  ];


  List<MeEntity> services = [
    MeEntity(label: LocaleKeys.support.tr(), icon: AppImages.support),

    MeEntity(label: LocaleKeys.survey.tr(), icon: AppImages.survey),

  ];



}
