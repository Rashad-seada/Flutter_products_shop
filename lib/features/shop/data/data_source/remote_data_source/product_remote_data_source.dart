import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../core/config/app_consts.dart';
import '../../../../../core/error/exception.dart';
import '../../../domain/entity/product_entity.dart';

abstract class ProductRemoteDataSource {

  Future<List<ProductEntity>> getProductById(int id);

  Future<List<ProductEntity>> getProductsById(List<int> ids);

  String getProductImageById(int id);

  Future<List<ProductEntity>> getProducts(int pageNumber);

}


class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {

  String domain;
  String serviceEmail;
  String servicePassword;
  final Dio client = Dio();

  ProductRemoteDataSourceImpl({required this.domain,required this.serviceEmail,required this.servicePassword});

  @override
  Future<List<ProductEntity>> getProductById(int id) async {
    try {
      List<Map<String,dynamic>> srvData = [{
        "Whr" : " AND id = $id"
      }];


      String jsonString = json.encode(srvData);
      String base64String = base64.encode(utf8.encode(jsonString));

      Response response = await client.get(
          AppConsts.baseUrl(domain,serviceEmail,servicePassword,base64String,823, 50,endPoint: "list/"),
          options: Options(
              receiveDataWhenStatusError: true,
              followRedirects: false,
              validateStatus: (status)=> true,
              receiveTimeout: const Duration(seconds: 60)
          )
      );

      List data = json.decode(response.data);

      return data.map((e) => ProductEntity.fromJson(e,response.statusCode!)).toList();

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
        "Whr" : " AND id IN $stringsOfIds"
      }];



      String jsonString = json.encode(srvData);
      String base64String = base64.encode(utf8.encode(jsonString));

      Response response = await client.get(
          AppConsts.baseUrl(domain,serviceEmail,servicePassword,base64String,823, 50,endPoint: "list/"),
          options: Options(
              receiveDataWhenStatusError: true,
              followRedirects: false,
              validateStatus: (status)=> true,
              receiveTimeout: const Duration(seconds: 60)
          )
      );

      List data = json.decode(response.data);

      return data.map((e) => ProductEntity.fromJson(e,response.statusCode!)).toList();

    } catch (e) {
      throw RemoteDataException();
    }
  }

  @override
  String getProductImageById(int id) {
    return AppConsts.baseImageUrl(domain,"$id");
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
          AppConsts.baseUrl(domain,serviceEmail,servicePassword,base64String,823, 50,endPoint: "list/"),
          options: Options(
              receiveDataWhenStatusError: true,
              followRedirects: false,
              validateStatus: (status)=> true,
              sendTimeout: const Duration(seconds: 30),
              receiveTimeout: const Duration(seconds: 60)
          )
      );

      List data = json.decode(response.data);

      List<ProductEntity> products = data.map((e) => ProductEntity.fromJson(e,response.statusCode!)).toList();

      return products;

    } catch (e) {
      throw RemoteDataException();
    }
  }


}