import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eng_shop/features/profile/domain/entities/change_password_entity.dart';
import 'package:eng_shop/features/profile/domain/entities/profile_entity.dart';
import 'package:eng_shop/features/profile/domain/entities/update_profile_entity.dart';

import '../../../../../core/config/app_consts.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/infrastructure/api/api.dart';

abstract class ProfileRemoteDataSource {

  Future<ProfileEntity> getProfile({required int id,required String email,required String password});

  Future<UpdateProfileEntity> updateProfile({required int id,String? name,String? email,String? mobile });

  Future<ChangePasswordEntity> changePassword({required int id,required String email,required String oldPassword,required String newPassword});

}


class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {

  String domain;
  String serviceEmail;
  String servicePassword;
  Api client;

  ProfileRemoteDataSourceImpl({required this.domain,required this.serviceEmail,required this.servicePassword,required this.client});


  @override
  Future<ChangePasswordEntity> changePassword({required int id,required String email,required String oldPassword,required String newPassword}) async {
    try {
      List<Map<String,dynamic>> srvData = [{
        "id":"$id",
        "uname": email,
        "upass": oldPassword,
        "opass": newPassword
      }];

      String jsonString = json.encode(srvData);

      String base64String = base64.encode(utf8.encode(jsonString));

      Response response = await client.get(
        AppConsts.baseUrl(domain,serviceEmail,servicePassword,base64String, 0,100),
      );

      Map<String,dynamic> data = json.decode(response.data);

      return ChangePasswordEntity.fromJson(data,response.statusCode!);
    } catch (e) {
      throw RemoteDataException();
    }
  }

  @override
  Future<ProfileEntity> getProfile({required int id, required String email, required String password}) async {
    try {
      List<Map<String,dynamic>> srvData = [{
        "id":"$id",
        "uname": email,
        "upass": password,
      }];

      String jsonString = json.encode(srvData);

      String base64String = base64.encode(utf8.encode(jsonString));

      Response response = await client.get(
        AppConsts.baseUrl(domain,serviceEmail,servicePassword,base64String, 0,110),
      );

      Map<String,dynamic> data = json.decode(response.data);

      return ProfileEntity.fromJson(data,response.statusCode!);
    } catch (e) {
      throw RemoteDataException();
    }
  }

  @override
  Future<UpdateProfileEntity> updateProfile({required int id,String? name,String? email,String? mobile }) async {
    try {
      List<Map<String,dynamic>> srvData = [{
        "id":"$id",
      }];

      if(name != null){
        srvData[0].addAll({
          "etxt":name,
          "atxt":name
        });
      }

      if(email != null){
        srvData[0].addAll({
          "uname":email,
          "umail":email
        });
      }

      if(mobile != null){
        srvData[0].addAll({
          "mobile": mobile
        });
      }

      String jsonString = json.encode(srvData);

      String base64String = base64.encode(utf8.encode(jsonString));

      Response response = await client.get(
        AppConsts.baseUrl(domain,serviceEmail,servicePassword,base64String, 0,10),
      );

      Map<String,dynamic> data = json.decode(response.data);

      return UpdateProfileEntity.fromJson(data,response.statusCode!);
    } catch (e) {
      throw RemoteDataException();
    }
  }

}