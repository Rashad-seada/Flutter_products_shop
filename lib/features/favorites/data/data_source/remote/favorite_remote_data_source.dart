import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eng_shop/features/favorites/domain/entities/add_favorite_entity.dart';
import 'package:eng_shop/features/shop/domain/entity/product_entity.dart';

import '../../../../../core/config/app_consts.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/infrastructure/api/api.dart';

abstract class FavoriteRemoteDataSource {

  Future<AddFavoriteEntity> addToFavorite({required String email,required String password,required int userId,required int productId,});

  Future<AddFavoriteEntity> removeFromFavorite({required String email,required String password,required int userId,required int productId,});

  Future<List<ProductEntity>> getUserFavorite({required String email,required String password,required int userId});

}

class FavoriteRemoteDataSourceImpl implements FavoriteRemoteDataSource {

  String domain;
  Api client;
  int userID;

  FavoriteRemoteDataSourceImpl({required this.domain,required this.client,required this.userID});


  @override
  Future<AddFavoriteEntity> addToFavorite({required String email,required String password,required int userId,required int productId,}) async {
    try {
      List<Map<String,dynamic>> srvData = [{
        "userid":"$userId",
        "item_id": productId,
      }];

      String jsonString = json.encode(srvData);

      String base64String = base64.encode(utf8.encode(jsonString));

      Response response = await client.get(
        AppConsts.baseUrl(domain,email,password,base64String,0,70,endPoint: "mrk/",userId: userId),
      );

      Map<String,dynamic> data = json.decode(response.data);

      return AddFavoriteEntity.fromJson(data,response.statusCode!);
    } catch (e) {
      throw RemoteDataException();
    }
  }

  @override
  Future<List<ProductEntity>> getUserFavorite({required String email,required String password,required int userId}) async {
    try {
      // List<Map<String,dynamic>> srvData = [{
      //   "userid":"$userId",
      // }];

      List<Map<String,dynamic>> srvData = [{
        "Whr":" AND item_id IN(SELECT item_id FROM st_items_fav WHERE userid=$userId)"
      }];

      String jsonString = json.encode(srvData);

      String base64String = base64.encode(utf8.encode(jsonString));

      // Response response = await client.get(
      //   AppConsts.baseUrl(domain,email,password,base64String,1267,10,endPoint: "list/"),
      // );

      Response response = await client.get(
        AppConsts.baseUrl(domain,email,password,base64String,823,10,endPoint: "list/",userId: userId),
      );

      print(AppConsts.baseUrl(domain,email,password,base64String,823,10,endPoint: "list/"));


      List data = json.decode(response.data);

      return data.map((e) => ProductEntity.fromJson(e)).toList();
    } catch (e) {
      throw RemoteDataException();
    }
  }

  @override
  Future<AddFavoriteEntity> removeFromFavorite({required String email,required String password,required int userId,required int productId,}) async {
    try {
      List<Map<String,dynamic>> srvData = [{
        "userid":"$userId",
        "item_id": productId,
      }];

      String jsonString = json.encode(srvData);

      String base64String = base64.encode(utf8.encode(jsonString));

      Response response = await client.get(
        AppConsts.baseUrl(domain,email,password,base64String,0,70,endPoint: "mrk/",userId: userId),
      );

      Map<String,dynamic> data = json.decode(response.data);

      return AddFavoriteEntity.fromJson(data,response.statusCode!);
    } catch (e) {
      throw RemoteDataException();
    }
  }

}