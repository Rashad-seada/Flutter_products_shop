import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../../../core/config/app_consts.dart';
import '../../../../../core/error/exception.dart';

abstract class SettingsLocalDataSource {

  Future<String?> getLanguage();

  Future<void> putLanguage(String language);

  Future<String?> getServiceProviderDomain();

  Future<void> putServiceProviderDomain(String domain);

  Future<String?> getServiceProviderEmail();

  Future<void> putServiceProviderEmail(String email);

  Future<String?> getServiceProviderPassword();

  Future<void> putServiceProviderPassword(String password);

}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {

  String get languageKey => AppConsts.languageKey;
  String get serviceProviderEmailKey => AppConsts.serviceProviderEmailKey;
  String get serviceProviderPasswordKey => AppConsts.serviceProviderPasswordKey;
  String get serviceProviderDomainKey => AppConsts.serviceProviderDomainKey;

  Box storage;

  SettingsLocalDataSourceImpl({required this.storage});


  @override
  Future<String?> getLanguage() async {
    try {
      return await storage.get(languageKey);
    } catch (e) {
      throw LocalDataException();
    }
  }

  @override
  Future<void> putLanguage(String language) async {
    try {
      await storage.put(languageKey,language);
    } catch (e) {
      throw LocalDataException();
    }
  }

  @override
  Future<String?> getServiceProviderEmail() async {
    try {
      return await storage.get(serviceProviderEmailKey);
    } catch (e) {
      throw LocalDataException();
    }
  }

  @override
  Future<void> putServiceProviderEmail(String email) async {
    try {
      await storage.put(serviceProviderEmailKey,email);
    } catch (e) {
      throw LocalDataException();
    }
  }

  @override
  Future<String?> getServiceProviderPassword() async {
    try {
      return await storage.get(serviceProviderPasswordKey);
    } catch (e) {
      throw LocalDataException();
    }
  }

  @override
  Future<void> putServiceProviderPassword(String password) async {
    try {
      await storage.put(serviceProviderPasswordKey,password);
    } catch (e) {
      throw LocalDataException();
    }
  }

  @override
  Future<String?> getServiceProviderDomain() async {
    try {
      final i = await storage.get(serviceProviderDomainKey);
      return await storage.get(serviceProviderDomainKey);
    } catch (e) {
      throw LocalDataException();
    }
  }

  @override
  Future<void> putServiceProviderDomain(String domain) async {
    try {
      await storage.put(serviceProviderDomainKey,domain);
    } catch (e) {
      throw LocalDataException();
    }

  }


}