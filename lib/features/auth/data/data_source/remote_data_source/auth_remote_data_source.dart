
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eng_shop/core/config/app_consts.dart';
import 'package:eng_shop/features/auth/domain/entity/registration_entity.dart';

abstract class AuthRemoteDataSource {

  Future<RegistrationEntity> register(String atext,String etext,String uname,String email,String upass,String mobile,);

}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  final Dio client = Dio();

  @override
  Future<RegistrationEntity> register(String atext, String etext, String uname, String email, String upass, String mobile) async  {

    Map<String,dynamic> srvData = {
      "atxt": atext,
      "etxt": etext,
      "uname": uname,
      "umail": email,
      "upass": upass,
      "mobile": mobile
    };

    String jsonString = json.encode(srvData);

    String base64String = base64.encode(utf8.encode(jsonString));

    Response response = await client.get(AppConsts.baseUrl(base64String, 10, 20));

    Map<String,dynamic> data = json.decode(response.data);

    return RegistrationEntity.fromJson(data);
  }

}