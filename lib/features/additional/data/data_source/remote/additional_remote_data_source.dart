
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eng_shop/features/additional/domain/entities/get_cities_entity.dart';
import 'package:eng_shop/features/additional/domain/entities/get_regions_entity.dart';

import '../../../../../core/config/app_consts.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/infrastructure/api/api.dart';
import '../../../domain/entities/get_countries_entity.dart';

abstract class AdditionalRemoteDataSource {

  Future<List<GetCountriesEntity>> getCountries();

  Future<List<GetRegionsEntity>> getRegions(int countryId);

  Future<List<GetCitiesEntity>> getCities(int regionsId);

}


class AdditionalRemoteDataSourceImpl implements AdditionalRemoteDataSource {


  String domain;
  String serviceEmail;
  String servicePassword;
  Api client;
  int userID;

  AdditionalRemoteDataSourceImpl({required this.domain,required this.serviceEmail,required this.servicePassword,required this.client,required this.userID});


  @override
  Future<List<GetCitiesEntity>> getCities(int regionsId) async {
    try {
      List<Map<String,dynamic>> srvData = [{
        "Whr":" And region_id=$regionsId",
      }];

      String jsonString = json.encode(srvData);

      String base64String = base64.encode(utf8.encode(jsonString));


    Response response = await client.get(
        AppConsts.baseUrl(domain,serviceEmail,servicePassword,base64String, 10, 20,userId: userID),
      );

      List data = json.decode(response.data);

      return data.map((e) => GetCitiesEntity.fromJson(e)).toList();
    } catch (e) {
      throw RemoteDataException();
    }
  }

  @override
  Future<List<GetCountriesEntity>> getCountries() async {
    try {

    Response response = await client.get(
    AppConsts.baseUrl(domain,serviceEmail,servicePassword,"", 10, 20,userId: userID),
    );

    List data = json.decode(response.data);

    return data.map((e) => GetCountriesEntity.fromJson(e)).toList();
    } catch (e) {
    throw RemoteDataException();
    }
  }

  @override
  Future<List<GetRegionsEntity>> getRegions(int countryId) async {
    try {
      List<Map<String,dynamic>> srvData = [{
        "Whr":" And country_id= $countryId",
      }];

      String jsonString = json.encode(srvData);

      String base64String = base64.encode(utf8.encode(jsonString));


      Response response = await client.get(
        AppConsts.baseUrl(domain,serviceEmail,servicePassword,base64String, 10, 20,userId: userID),
      );

      List data = json.decode(response.data);

      return data.map((e) => GetRegionsEntity.fromJson(e)).toList();
    } catch (e) {
      throw RemoteDataException();
    }
  }


}