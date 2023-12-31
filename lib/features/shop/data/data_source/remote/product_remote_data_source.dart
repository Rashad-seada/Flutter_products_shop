import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eng_shop/core/infrastructure/api/api.dart';
import 'package:eng_shop/features/shop/domain/entity/get_product_images_entity.dart';

import '../../../../../core/config/app_consts.dart';
import '../../../../../core/error/exception.dart';
import '../../../domain/entity/product_entity.dart';

abstract class ProductRemoteDataSource {

  Future<List<ProductEntity>> getProductById(int id);

  Future<List<ProductEntity>> getProductsById(List<int> ids);

  String getProductImageById(int id);

  Future<List<ProductEntity>> getProducts(int pageNumber);

  Future<GetProductImagesEntity> getProductImagesById(int id);


}


class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {

  String domain;
  String serviceEmail;
  String servicePassword;
  Api client;
  int userId;

  ProductRemoteDataSourceImpl({required this.domain,required this.serviceEmail,required this.servicePassword,required this.client,required this.userId});

  @override
  Future<List<ProductEntity>> getProductById(int id) async {
    try {
      List<Map<String,dynamic>> srvData = [{
        "Whr" : " AND id = $id"
      }];


      String jsonString = json.encode(srvData);
      String base64String = base64.encode(utf8.encode(jsonString));

      Response response = await client.get(
          AppConsts.baseUrl(domain,serviceEmail,servicePassword,base64String,823, 50,endPoint: "list/",userId:userId),
      );

      List data = json.decode(response.data);

      return data.map((e) => ProductEntity.fromJson(e)).toList();

    } catch (e) {
      throw RemoteDataException();
    }
  }


  @override
  Future<List<ProductEntity>> getProductsById(List<int> ids) async {
    try {

      String stringsOfIds = "";

      for(int i = 0; i < ids.length;i++) {
        if(i == 0) {
          stringsOfIds += "(";
        }

        if(i != 0){
          stringsOfIds += ",";
        }

        stringsOfIds += "${ids[i]}";



        if(i == ids.length - 1){
          stringsOfIds += ")";
        }
      }


      List<Map<String,dynamic>> srvData = [{
        "Whr" : " AND id IN $stringsOfIds",
        "Pgsize": "1000",

      }];




      String jsonString = json.encode(srvData);
      String base64String = base64.encode(utf8.encode(jsonString));

      Response response = await client.get(
          AppConsts.baseUrl(domain,serviceEmail,servicePassword,base64String,823, 50,endPoint: "list/",userId:userId),
      );

      List data = json.decode(response.data);


      return data.map((e) => ProductEntity.fromJson(e)).toList();

    } catch (e) {
      throw RemoteDataException();
    }
  }

  @override
  String getProductImageById(int id) {
    return AppConsts.baseProductImageUrl(domain,"$id");
  }

  @override
  Future<List<ProductEntity>> getProducts(int pageNumber) async {
    try {

      List<Map<String,dynamic>> srvData = [{
        "Pgsize": "10",
        "Pgno": "$pageNumber"
      }];


      String jsonString = json.encode(srvData);
      String base64String = base64.encode(utf8.encode(jsonString));

      Response response = await client.get(
          AppConsts.baseUrl(domain,serviceEmail,servicePassword,base64String,823, 50,endPoint: "list/",userId: userId),
      );

      List data = json.decode(response.data);

      print(response.data);

      List<ProductEntity> products = data.map((e) => ProductEntity.fromJson(e)).toList();

      return products;

    } catch (e) {
      print(e);
      throw RemoteDataException();
    }
  }

  @override
  Future<GetProductImagesEntity> getProductImagesById(int id) async {
    try {

      List<Map<String,dynamic>> srvData = [{
        "Whr": " AND item_id=$id"
      }];


      String jsonString = json.encode(srvData);
      String base64String = base64.encode(utf8.encode(jsonString));

      Response response = await client.get(
        AppConsts.baseUrl(domain,serviceEmail,servicePassword,base64String,862, 20,endPoint: "list/",userId: userId),
      );

      List data = json.decode(response.data);

      print(response.data);

      return GetProductImagesEntity.fromJson(response.data);

    } catch (e) {
      throw RemoteDataException();
    }
  }


}