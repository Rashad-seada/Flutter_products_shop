
import 'package:eng_shop/core/config/app_consts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';


abstract class AuthLocalDataSource {

    Future<int> getUserID();

    Future<void> putUserID(int userId);

}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {

    String get userInfoKey => AppConsts.userInfoKey;

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
    Future<int> getUserID() async {
      return await instance.then((value) => value.get(userInfoKey));
    }

    @override
    Future<void> putUserID(int userId) async {
      await instance.then((value) => value.put(userInfoKey,userId));

    }


}