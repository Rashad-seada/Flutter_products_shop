
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eng_shop/core/config/app_consts.dart';
import 'package:eng_shop/core/error/exception.dart';
import 'package:eng_shop/features/auth/domain/entity/activate_phone_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/login_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/registration_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/reset_password_by_email_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/reset_password_by_sms_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/send_sms_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/validate_code_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/validate_email_entity.dart';

import '../../../../../core/infrastructure/api/api.dart';
import '../../../domain/entity/validate_phone_entity.dart';

abstract class AuthRemoteDataSource {

  Future<RegistrationEntity> register(String atext,String etext,String uname,String email,String upass,String mobile,);

  Future<ValidateEmailEntity> validateEmail(String email);

  Future<ValidatePhoneEntity> validatePhoneNumber(String phoneNumber);

  Future<ActivatePhoneEntity> activateAccountSMS(String phoneNumber,String pin,String expectedPin);

  Future<LoginEntity> login(String email,String password,bool isMobile);

  Future<SendSmsEntity> sendSms(String number);

  Future<ValidateCodeEntity> validateSmsCode(String number,String smsCode);

  Future<ResetPasswordBySMSEntity> resetPasswordBySMS(String number,String smsCode,String newPassword);

  Future<ResetPasswordByEmailEntity> resetPasswordByEmail(String email);

}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  String domain;
  String serviceEmail;
  String servicePassword;
  Api client;

  AuthRemoteDataSourceImpl({required this.domain,required this.serviceEmail,required this.servicePassword,required this.client});



  @override
  Future<RegistrationEntity> register(String atext, String etext, String uname, String email, String upass, String mobile) async  {

    try {
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

      Response response = await client.get(
          AppConsts.baseUrl(domain,serviceEmail,servicePassword,base64String, 10, 20),
      );

      Map<String,dynamic> data = json.decode(response.data);

      return RegistrationEntity.fromJson(data,response.statusCode!);
    } catch (e) {
      throw RemoteDataException();
    }

  }

  @override
  Future<ValidateEmailEntity> validateEmail(String email) async {
    try {
      List<Map<String,dynamic>> srvData = [{"umail": email,}];

      String jsonString = json.encode(srvData);
      String base64String = base64.encode(utf8.encode(jsonString));

      Response response = await client.get(
          AppConsts.baseUrl(domain,serviceEmail,servicePassword,base64String, 0, 30),

      );


      Map<String,dynamic> data = json.decode(response.data);

      return ValidateEmailEntity.fromJson(data,response.statusCode!);
    } catch (e) {
      throw RemoteDataException();
    }

  }

  @override
  Future<ValidatePhoneEntity> validatePhoneNumber(String phoneNumber) async {
    try {
      List<Map<String,dynamic>> srvData = [{"mobile": phoneNumber,}];

      String jsonString = json.encode(srvData);
      String base64String = base64.encode(utf8.encode(jsonString));

      Response response = await client.get(
          AppConsts.baseUrl(domain,serviceEmail,servicePassword,base64String, 0, 40),
      );

      Map<String,dynamic> data = json.decode(response.data);

      return ValidatePhoneEntity.fromJson(data,response.statusCode!);
    } catch (e) {
      throw RemoteDataException();
    }

  }

  @override
  Future<ActivatePhoneEntity> activateAccountSMS(String phoneNumber, String pin,String expectedPin) async {
    try {
      List<Map<String,dynamic>> srvData = [{
        "mobile": phoneNumber,
        "mcode": expectedPin,
        "ncode": pin,
      }];

      String jsonString = json.encode(srvData);
      String base64String = base64.encode(utf8.encode(jsonString));

      Response response = await client.get(
          AppConsts.baseUrl(domain,serviceEmail,servicePassword,base64String, 0, 50),
      );

      Map<String,dynamic> data = json.decode(response.data);

      return ActivatePhoneEntity.fromJson(data,response.statusCode!);
    } catch (e) {
      throw RemoteDataException();
    }

  }

  @override
  Future<LoginEntity> login(String email, String password,bool isMobile) async {
    try {
      List<Map<String,dynamic>> srvData = [{
        "uname": email,
        "upass": password,
        "ismob": (isMobile)? "1" : "0"
      }];

      String jsonString = json.encode(srvData);
      String base64String = base64.encode(utf8.encode(jsonString));

      Response response = await client.get(
          AppConsts.baseUrl(domain,serviceEmail,servicePassword,base64String, 0, 10),
      );

      Map<String,dynamic> data = json.decode(response.data);

      return LoginEntity.fromJson(data,response.statusCode!);
    } catch (e) {
      throw RemoteDataException();
    }

  }

  @override
  Future<SendSmsEntity> sendSms(String number) async {
    try {
      List<Map<String,dynamic>> srvData = [{
        "mobile": number,
        "is_code_sms": "1",
      }];


      String jsonString = json.encode(srvData);
      String base64String = base64.encode(utf8.encode(jsonString));

      Response response = await client.get(
          AppConsts.baseUrl(domain,serviceEmail,servicePassword,base64String, 0, 60),
      );

      Map<String,dynamic> data = json.decode(response.data);

      return SendSmsEntity.fromJson(data,response.statusCode!);
    } catch (e) {
      throw RemoteDataException();
    }

  }

  @override
  Future<ValidateCodeEntity> validateSmsCode(String number, String smsCode) async {
    try {
      List<Map<String,dynamic>> srvData = [{
        "mobile": number,
        "mcode": smsCode,
      }];


      String jsonString = json.encode(srvData);
      String base64String = base64.encode(utf8.encode(jsonString));

      Response response = await client.get(
          AppConsts.baseUrl(domain,serviceEmail,servicePassword,base64String, 0, 70),
      );

      Map<String,dynamic> data = json.decode(response.data);

      return ValidateCodeEntity.fromJson(data,response.statusCode!);
    } catch (e){
      throw RemoteDataException();
    }

  }

  @override
  Future<ResetPasswordBySMSEntity> resetPasswordBySMS(String number, String smsCode, String newPassword) async {
    try {
      List<Map<String,dynamic>> srvData = [{
        "mobile": number,
        "mcode": smsCode,
        "upass": newPassword,
      }];


      String jsonString = json.encode(srvData);
      String base64String = base64.encode(utf8.encode(jsonString));

      Response response = await client.get(
          AppConsts.baseUrl(domain,serviceEmail,servicePassword,base64String, 0, 80),
      );

      Map<String,dynamic> data = json.decode(response.data);

      return ResetPasswordBySMSEntity.fromJson(data,response.statusCode!);
    } catch (e) {
      throw RemoteDataException();
    }

  }

  @override
  Future<ResetPasswordByEmailEntity> resetPasswordByEmail(String email) async {
    try {
      List<Map<String,dynamic>> srvData = [{
        "umail": email,
        "is_code_sms":"1"
      }];


      String jsonString = json.encode(srvData);
      String base64String = base64.encode(utf8.encode(jsonString));

      Response response = await client.get(
          AppConsts.baseUrl(domain,serviceEmail,servicePassword,base64String, 0, 90),
      );

      Map<String,dynamic> data = json.decode(response.data);

      print(response.data);

      return ResetPasswordByEmailEntity.fromJson(data,response.statusCode!);
    } catch (e) {
      throw RemoteDataException();
    }
  }

}