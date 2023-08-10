import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../core/config/app_consts.dart';

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
    return await instance.then((value) => value.get(languageKey));
  }

  @override
  Future<void> putLanguage(String language) async {
    await instance.then((value) => value.put(languageKey,language));
  }

  @override
  Future<String> getServiceProviderEmail() async {
    return await instance.then((value) => value.get(serviceProviderEmailKey));
  }

  @override
  Future<void> putServiceProviderEmail(String email) async {
    await instance.then((value) => value.put(serviceProviderEmailKey,email));
  }

  @override
  Future<String> getServiceProviderPassword() async {
    return await instance.then((value) => value.get(serviceProviderPasswordKey));
  }

  @override
  Future<void> putServiceProviderPassword(String password) async {
    await instance.then((value) => value.put(serviceProviderPasswordKey,password));
  }

  @override
  Future<String> getServiceProviderDomain() async {

    return await instance.then((value) => value.get(serviceProviderDomainKey));
  }

  @override
  Future<void> putServiceProviderDomain(String domain) async {
    await instance.then((value) => value.put(serviceProviderDomainKey,domain));

  }


}