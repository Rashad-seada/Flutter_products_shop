
import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/config/app_consts.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../core/error/exception.dart';


abstract class AuthLocalDataSource {

    Future<int?> getUserID();
    Future<void> putUserID(int userId);
    Future<void> deleteUserID();

    Future<String?> getEmail();
    Future<void> putEmail(String email);
    Future<void> deleteEmail();

    Future<String?> getPassword();
    Future<void> putPassword(String password);
    Future<void> deletePassword();

    Future<int?> getIsSignedIn();
    Future<void> putIsSignedIn(int isFirstTime);

    Future<String?> getUserType();
    Future<void> putUserType(String utype);
    Future<void> deleteUserType();


}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {

  FlutterSecureStorage secureStorage;
  Box storage;

  AuthLocalDataSourceImpl({required this.secureStorage,required this.storage});

  String get userIdKey => AppConsts.userIdKey;
  String get isFirstTimeKey => AppConsts.userIdKey;
  String get emailKey => AppConsts.emailKey;
  String get passwordKey => AppConsts.passwordKey;
  String get userTypeKey => AppConsts.userTypeKey;

  @override
  Future<int?> getIsSignedIn() async {
    try {
      return await storage.get(isFirstTimeKey);
    } catch (e) {
      throw LocalDataException();
    }
  }

  @override
  Future<void> putIsSignedIn(int isFirstTime) async {
    try {
      await storage.put(isFirstTimeKey,isFirstTime);
    } catch (e) {
      throw LocalDataException();
    }
  }

  @override
  Future<String?> getEmail() async {
    try {
      await secureStorage.read(key: emailKey,);
    } catch (e) {
      throw LocalDataException();
    }
  }

  @override
  Future<String?> getPassword() async {
    try {
      await secureStorage.read(key: passwordKey);
    } catch (e) {
      throw LocalDataException();
    }
  }

  @override
  Future<void> putEmail(String email) async {
    try {
      await secureStorage.write(key: emailKey, value: email);
    } catch (e) {
      throw LocalDataException();
    }
  }

  @override
  Future<void> putPassword(String password) async {
    try {
      await secureStorage.write(key: passwordKey, value: password);
    } catch (e) {
      throw LocalDataException();
    }
  }

  @override
  Future<int?> getUserID() async {
    try {
      String? idString = await secureStorage.read(key: userIdKey);
      int? id = int.tryParse(idString!);

      return id;
    } catch (e) {
      throw LocalDataException();
    }
  }

  @override
  Future<void> putUserID(int userId) async {
    try {
      await secureStorage.write(key: userIdKey, value: userId.toString() );
    } catch (e) {
      throw LocalDataException();
    }
  }

  @override
  Future<String?> getUserType() async {
    try {
      return await storage.get(userTypeKey);
    } catch (e) {
      throw LocalDataException();
    }
  }

  @override
  Future<void> putUserType(String utype) async {
    try {
      await storage.put(userTypeKey,utype);
    } catch (e) {
      throw LocalDataException();
    }
  }

  @override
  Future<void> deleteEmail() async {
    try {
      await secureStorage.delete(key: emailKey);
    } catch (e) {
      throw LocalDataException();
    }
  }

  @override
  Future<void> deleteUserID() async {
    try {
      await secureStorage.delete(key: userIdKey);
    } catch (e) {
      throw LocalDataException();
    }
  }

  @override
  Future<void> deletePassword() async {
    try {
      await secureStorage.delete(key: passwordKey);
    } catch (e) {
      throw LocalDataException();
    }
  }

  @override
  Future<void> deleteUserType() async {
    try {
      await storage.delete( userTypeKey);
    } catch (e) {
      throw LocalDataException();
    }
  }


}