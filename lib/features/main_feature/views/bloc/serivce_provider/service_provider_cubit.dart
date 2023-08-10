import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../data/data_source/local_data_source/settings_local_data_source.dart';

part 'service_provider_state.dart';

class ServiceProviderCubit extends Cubit<ServiceProviderState> {
  ServiceProviderCubit() : super(ServiceProviderInitial());

  TextEditingController domainController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  SettingsLocalDataSource mainLocalDataSource = SettingsLocalDataSourceImpl();

  initConfig() async {
    emit(ServiceProviderLoading());
    domainController.text = await mainLocalDataSource.getServiceProviderDomain();
    emailController.text = await mainLocalDataSource.getServiceProviderEmail();
    passwordController.text = await mainLocalDataSource.getServiceProviderPassword();
    emit(ServiceProviderInitial());
  }

  onSaveClick(BuildContext context) async {
    emit(ServiceProviderSavingConfig());
    await mainLocalDataSource.putServiceProviderDomain(domainController.text);
    await mainLocalDataSource.putServiceProviderEmail(emailController.text);
    await mainLocalDataSource.putServiceProviderPassword(passwordController.text);
    emit(ServiceProviderInitial());
    Navigator.pop(context);
  }


}
