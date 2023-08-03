
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eng_shop/core/config/app_consts.dart';
import 'package:eng_shop/features/auth/domain/entity/activate_phone_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/registration_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/validate_email_entity.dart';

import '../../../domain/entity/validate_phone_entity.dart';

abstract class AuthRemoteDataSource {

  Future<RegistrationEntity> register(String atext,String etext,String uname,String email,String upass,String mobile,);

  Future<ValidateMobileEntity> validateEmail(String email);

  Future<ValidatePhoneEntity> validatePhoneNumber(String phoneNumber);

  Future<ActivatePhoneEntity> activateAccountSMS(String phoneNumber,String pin,String expectedPin);


}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  final Dio client = Dio();

  @override
  Future<RegistrationEntity> register(String atext, String etext, String uname, String email, String upass, String mobile) async  {

    List<Map<String,dynamic>> srvData = [{
      "id":"0",
      "atxt": atext,
      "etxt": etext,
      "uname": uname,
      "umail": email,
      "upass": upass,
      "mobile": mobile
    }];

    String jsonString = json.encode(srvData);

    String base64String = base64.encode(utf8.encode(jsonString));

    Response response = await client.get(AppConsts.baseUrl(base64String, 10, 20));


    Map<String,dynamic> data = json.decode(response.data);

    return RegistrationEntity.fromJson(data);
  }

  @override
  Future<ValidateMobileEntity> validateEmail(String email) async {
    List<Map<String,dynamic>> srvData = [{"umail": email,}];

    String jsonString = json.encode(srvData);
    String base64String = base64.encode(utf8.encode(jsonString));

    Response response = await client.get(AppConsts.baseUrl(base64String, 0, 30));

    print(AppConsts.baseUrl(base64String, 0, 30));

    Map<String,dynamic> data = json.decode(response.data);

    return ValidateMobileEntity.fromJson(data);
  }

  @override
  Future<ValidatePhoneEntity> validatePhoneNumber(String phoneNumber) async {
    List<Map<String,dynamic>> srvData = [{"mobile": phoneNumber,}];

    String jsonString = json.encode(srvData);
    String base64String = base64.encode(utf8.encode(jsonString));

    Response response = await client.get(AppConsts.baseUrl(base64String, 0, 40));

    Map<String,dynamic> data = json.decode(response.data);

    return ValidatePhoneEntity.fromJson(data);
  }

  @override
  Future<ActivatePhoneEntity> activateAccountSMS(String phoneNumber, String pin,String expectedPin) async {
    List<Map<String,dynamic>> srvData = [{
      "mobile": phoneNumber,
      "mcode": expectedPin,
      "ncode": pin,
    }];

    String jsonString = json.encode(srvData);
    String base64String = base64.encode(utf8.encode(jsonString));

    Response response = await client.get(AppConsts.baseUrl(base64String, 0, 50));

    Map<String,dynamic> data = json.decode(response.data);

    return ActivatePhoneEntity.fromJson(data);
  }

}