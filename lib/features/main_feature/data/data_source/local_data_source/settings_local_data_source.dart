import 'package:easy_localization/easy_localization.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../core/config/app_consts.dart';
import '../../../../../core/error/exception.dart';

abstract class SettingsLocalDataSource {

  Future<String> getLanguage();

  Future<void> putLanguage(String language);

  Future<String> getServiceProviderDomain();

  Future<void> putServiceProviderDomain(String domain);

  Future<String> getServiceProviderEmail();

  Future<void> putServiceProviderEmail(String email);

  Future<String> getServiceProviderPassword();

  Future<void> putServiceProviderPassword(String password);

}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {

  String get languageKey => AppConsts.languageKey;
  String get serviceProviderEmailKey => AppConsts.serviceProviderEmailKey;
  String get serviceProviderPasswordKey => AppConsts.serviceProviderPasswordKey;
  String get serviceProviderDomainKey => AppConsts.serviceProviderDomainKey;

  Future<Box> dbInit()async {
    await Hive.initFlutter();
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    return await Hive.openBox(AppConsts.prefDBName);
  }

  Future<Box> get instance async {
    return await dbInit();
  }



  @override
  Future<String> getLanguage() async {
    try {
      return await instance.then((value) => value.get(languageKey));
    } catch (e) {
      throw LocalDataException();
    }
  }

  @override
  Future<void> putLanguage(String language) async {
    try {
      await instance.then((value) => value.put(languageKey,language));
    } catch (e) {
      throw LocalDataException();
    }
  }

  @override
  Future<String> getServiceProviderEmail() async {
    try {
      return await instance.then((value) => value.get(serviceProviderEmailKey));
    } catch (e) {
      throw LocalDataException();
    }
  }

  @override
  Future<void> putServiceProviderEmail(String email) async {
    try {
      await instance.then((value) => value.put(serviceProviderEmailKey,email));
    } catch (e) {
      throw LocalDataException();
    }
  }

  @override
  Future<String> getServiceProviderPassword() async {
    try {
      return await instance.then((value) => value.get(serviceProviderPasswordKey));
    } catch (e) {
      throw LocalDataException();
    }
  }

  @override
  Future<void> putServiceProviderPassword(String password) async {
    try {
      await instance.then((value) => value.put(serviceProviderPasswordKey,password));
    } catch (e) {
      throw LocalDataException();
    }
  }

  @override
  Future<String> getServiceProviderDomain() async {
    try {
      return await instance.then((value) => value.get(serviceProviderDomainKey));
    } catch (e) {
      throw LocalDataException();
    }
  }

  @override
  Future<void> putServiceProviderDomain(String domain) async {
    try {
      await instance.then((value) => value.put(serviceProviderDomainKey,domain));
    } catch (e) {
      throw LocalDataException();
    }

  }


}