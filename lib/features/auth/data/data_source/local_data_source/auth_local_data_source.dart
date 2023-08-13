
import 'package:eng_shop/core/config/app_consts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../core/error/exception.dart';


abstract class AuthLocalDataSource {

    Future<int?> getUserID();

    Future<void> putUserID(int userId);

    Future<int?> getIsFirstTime();

    Future<void> putIsFirstTime(int isFirstTime);

}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {

  String get userInfoKey => AppConsts.userInfoKey;
  String get isFirstTimeKey => AppConsts.userInfoKey;

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
  Future<int?> getUserID() async {
    try {
      return await instance.then((value) => value.get(userInfoKey));
    } catch (e) {
      throw LocalDataException();
    }
  }

  @override
  Future<void> putUserID(int userId) async {
    try {
      await instance.then((value) => value.put(userInfoKey,userId));
    } catch (e) {
      throw LocalDataException();
    }

  }

  @override
  Future<int?> getIsFirstTime() async {
    try {
      return await instance.then((value) => value.get(isFirstTimeKey));
    } catch (e) {
      throw LocalDataException();
    }

  }

  @override
  Future<void> putIsFirstTime(int isFirstTime) async {
    try {
      await instance.then((value) => value.put(isFirstTimeKey,isFirstTime));
    } catch (e) {
      throw LocalDataException();
    }


  }


}