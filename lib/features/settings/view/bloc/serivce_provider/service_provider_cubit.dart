import 'package:bloc/bloc.dart';
import 'package:eng_shop/core/di/app_module.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../settings/data/data_source/local/settings_local_data_source.dart';

part 'service_provider_state.dart';

class ServiceProviderCubit extends Cubit<ServiceProviderState> {
  ServiceProviderCubit() : super(ServiceProviderInitial());

  bool isEditable = false;

  TextEditingController domainController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  initConfig() async {
    emit(ServiceProviderLoading());
    getIt<SettingsLocalDataSource>().getServiceProviderDomain().then((value) => domainController.text = value!) ;
    getIt<SettingsLocalDataSource>().getServiceProviderEmail().then((value) => emailController.text = value!);
    getIt<SettingsLocalDataSource>().getServiceProviderPassword().then((value) => passwordController.text = value!);
    isEditable = false;
    emit(ServiceProviderInitial());
  }

  onSaveClick(BuildContext context) async {
    emit(ServiceProviderSavingConfig());
    getIt<SettingsLocalDataSource>().putServiceProviderDomain(domainController.text);
    getIt<SettingsLocalDataSource>().putServiceProviderEmail(emailController.text);
    getIt<SettingsLocalDataSource>().putServiceProviderPassword(passwordController.text);
    emit(ServiceProviderInitial());
    Navigator.pop(context);
  }

  toggleEdit() {
    emit(ServiceProviderLoading());
    isEditable = !isEditable;
    emit(ServiceProviderInitial());
  }


}
