
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eng_shop/core/config/app_consts.dart';
import 'package:eng_shop/features/auth/domain/entity/activate_phone_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/login_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/registration_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/reset_password_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/send_sms_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/validate_code_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/validate_email_entity.dart';

import '../../../domain/entity/validate_phone_entity.dart';

abstract class AuthRemoteDataSource {

  Future<RegistrationEntity> register(String atext,String etext,String uname,String email,String upass,String mobile,);

  Future<ValidateEmailEntity> validateEmail(String email);

  Future<ValidatePhoneEntity> validatePhoneNumber(String phoneNumber);

  Future<ActivatePhoneEntity> activateAccountSMS(String phoneNumber,String pin,String expectedPin);

  Future<LoginEntity> login(String email,String password,bool isMobile);

  Future<SendSmsEntity> sendSms(String number);

  Future<ValidateCodeEntity> validateSmsCode(String number,String smsCode);

  Future<ResetPasswordEntity> resetPassword(String number,String smsCode,String newPassword);


}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  String domain;
  String serviceEmail;
  String servicePassword;

  AuthRemoteDataSourceImpl({required this.domain,required this.serviceEmail,required this.servicePassword});


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

    Response response = await client.get(AppConsts.baseUrl(domain,serviceEmail,servicePassword,base64String, 10, 20));


    Map<String,dynamic> data = json.decode(response.data);

    return RegistrationEntity.fromJson(data);
  }

  @override
  Future<ValidateEmailEntity> validateEmail(String email) async {
    List<Map<String,dynamic>> srvData = [{"umail": email,}];

    String jsonString = json.encode(srvData);
    String base64String = base64.encode(utf8.encode(jsonString));

    Response response = await client.get(AppConsts.baseUrl(domain,serviceEmail,servicePassword,base64String, 0, 30));


    Map<String,dynamic> data = json.decode(response.data);

    return ValidateEmailEntity.fromJson(data);
  }

  @override
  Future<ValidatePhoneEntity> validatePhoneNumber(String phoneNumber) async {
    List<Map<String,dynamic>> srvData = [{"mobile": phoneNumber,}];

    String jsonString = json.encode(srvData);
    String base64String = base64.encode(utf8.encode(jsonString));

    Response response = await client.get(AppConsts.baseUrl(domain,serviceEmail,servicePassword,base64String, 0, 40));

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

    Response response = await client.get(AppConsts.baseUrl(domain,serviceEmail,servicePassword,base64String, 0, 50));

    Map<String,dynamic> data = json.decode(response.data);

    return ActivatePhoneEntity.fromJson(data);
  }

  @override
  Future<LoginEntity> login(String email, String password,bool isMobile) async {

    List<Map<String,dynamic>> srvData = [{
      "uname": email,
      "upass": password,
      "ismob": (isMobile)? "1" : "0"
    }];


    String jsonString = json.encode(srvData);
    String base64String = base64.encode(utf8.encode(jsonString));

    Response response = await client.get(AppConsts.baseUrl(domain,serviceEmail,servicePassword,base64String, 0, 10));

    Map<String,dynamic> data = json.decode(response.data);

    return LoginEntity.fromJson(data);
  }

  @override
  Future<SendSmsEntity> sendSms(String number) async {
    List<Map<String,dynamic>> srvData = [{
      "mobile": number,
      "is_code_sms": "1",
    }];


    String jsonString = json.encode(srvData);
    String base64String = base64.encode(utf8.encode(jsonString));

    Response response = await client.get(AppConsts.baseUrl(domain,serviceEmail,servicePassword,base64String, 0, 60));

    Map<String,dynamic> data = json.decode(response.data);

    return SendSmsEntity.fromJson(data);
  }

  @override
  Future<ValidateCodeEntity> validateSmsCode(String number, String smsCode) async {
    List<Map<String,dynamic>> srvData = [{
      "mobile": number,
      "mcode": smsCode,
    }];


    String jsonString = json.encode(srvData);
    String base64String = base64.encode(utf8.encode(jsonString));

    Response response = await client.get(AppConsts.baseUrl(domain,serviceEmail,servicePassword,base64String, 0, 70));

    Map<String,dynamic> data = json.decode(response.data);

    return ValidateCodeEntity.fromJson(data);
  }

  @override
  Future<ResetPasswordEntity> resetPassword(String number, String smsCode, String newPassword) async {
    List<Map<String,dynamic>> srvData = [{
      "mobile": number,
      "mcode": smsCode,
      "upass": newPassword,
    }];


    String jsonString = json.encode(srvData);
    String base64String = base64.encode(utf8.encode(jsonString));

    Response response = await client.get(AppConsts.baseUrl(domain,serviceEmail,servicePassword,base64String, 0, 80));

    Map<String,dynamic> data = json.decode(response.data);

    return ResetPasswordEntity.fromJson(data);
  }

}