import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../core/config/app_consts.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/infrastructure/api/api.dart';
import '../../../domain/entities/category_entity.dart';
import '../../../../shop/domain/entity/product_entity.dart';

abstract class CategoryRemoteDataSource {

  Future<List<CategoryEntity>> getCategories();

  Future<List<CategoryEntity>> getSubCategoriesById(int parentCategoryId);

  Future<List<ProductEntity>> getCategoryProducts(int pageNumber,CategoryEntity categoryEntity);
  

}


class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {

  String domain;
  String serviceEmail;
  String servicePassword;
  Api client;
  int userId;

  CategoryRemoteDataSourceImpl({required this.domain,required this.serviceEmail,required this.servicePassword,required this.client,required this.userId});


  @override
  Future<List<CategoryEntity>> getCategories() async {
    try {
      List<Map<String,dynamic>> srvData = [{
        "whr" : " AND parent_id=0 ",
      }];


      String jsonString = json.encode(srvData);
      String base64String = base64.encode(utf8.encode(jsonString));


      Response response = await client.get(
          AppConsts.baseUrl(domain,serviceEmail,servicePassword,base64String,858, 10,endPoint: "list/",userId: userId),
      );

      List data = json.decode(response.data);


      return data.map((e) => CategoryEntity.fromJson(e,response.statusCode!)).toList();

    } catch (e) {
      print(e);
      throw RemoteDataException();
    }
  }

  @override
  Future<List<ProductEntity>> getCategoryProducts(int pageNumber,CategoryEntity categoryEntity) async {
    try {
      List<Map<String,dynamic>> srvData = [{
        "whr" : "AND category_id IN(${(categoryEntity.frontTreeIds!.trim().isEmpty)? categoryEntity.id : categoryEntity.frontTreeIds})",
        "Pgsize": "10",
        "Pgno": "$pageNumber"
      }];



      String jsonString = json.encode(srvData);
      String base64String = base64.encode(utf8.encode(jsonString));

      Response response = await client.get(
          AppConsts.baseUrl(domain,serviceEmail,servicePassword,base64String,823, 50,endPoint: "list/",userId: userId)
      );

      List data = json.decode(response.data);

      return data.map((e) => ProductEntity.fromJson(e,response.statusCode!)).toList();

    } catch (e) {

      throw RemoteDataException();
    }
  }

  @override
  Future<List<CategoryEntity>> getSubCategoriesById(int parentCategoryId) async {
    try {
      List<Map<String,dynamic>> srvData = [{
        "whr" : " AND parent_id=$parentCategoryId "
      }];


      String jsonString = json.encode(srvData);
      String base64String = base64.encode(utf8.encode(jsonString));

      Response response = await client.get(
          AppConsts.baseUrl(domain,serviceEmail,servicePassword,base64String,858, 10,endPoint: "list/",userId: userId),
      );

      List data = json.decode(response.data);

      return data.map((e) => CategoryEntity.fromJson(e,response.statusCode!)).toList();

    } catch (e) {
      print(e);
      throw RemoteDataException();
    }
  }

  


}