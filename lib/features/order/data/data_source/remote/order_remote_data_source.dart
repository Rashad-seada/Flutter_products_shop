import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eng_shop/features/cart/domain/entity/cart_entity.dart';
import 'package:flutter/services.dart';

import '../../../../../core/config/app_consts.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/infrastructure/api/api.dart';
import '../../../domain/entities/make_order_entity.dart';
import '../../../domain/entities/make_order_items_entity.dart';

abstract class OrderRemoteDataSource {


  Future<MakeOrderEntity> makeOrder(
      {required String countryId,
        required String regionId,
        required String cityId,
        required String district,
        required String address,
        required String mobile,
        required String note,
        required int itemsCount,
        required String paidAmount,
        required String paidMethodId});


  Future<MakeOrderItemsEntity> makeOrderItems(
      {required String orderId,
        required String paidAmount,
        required List<CartEntity> products});

}


class OrderRemoteDataSourceImpl implements  OrderRemoteDataSource {

  String domain;
  String serviceEmail;
  String servicePassword;
  Api client;
  int userId;

  OrderRemoteDataSourceImpl({required this.domain,required this.serviceEmail,required this.servicePassword,required this.client,required this.userId});


  @override
  Future<MakeOrderEntity> makeOrder({
    required String countryId,
    required String regionId,
    required String cityId,
    required String district,
    required String address,
    required String mobile,
    required String note,
    required int itemsCount,
    required String paidAmount,
    required String paidMethodId}) async {

    try {
      List<Map<String,dynamic>> srvData = [{
        "userid": userId,
        "country_id": countryId ,
        "region_id": regionId,
        "city_id": cityId,
        "district": district,
        "xaddress": address,
        "mob": mobile,
        "notes": note ,
        "items_count": itemsCount,
        "paid_amount": paidAmount,
        "paid_method_id": paidMethodId
      }];


      String jsonString = json.encode(srvData);

      String base64String = base64.encode(utf8.encode(jsonString));

      Response response = await client.get(
        AppConsts.baseUrl(domain,serviceEmail,servicePassword,base64String, 0,80,userId: userId,endPoint: "mrk/"),
      );

      final data = json.decode(response.data);

      //Clipboard.setData(ClipboardData(text: AppConsts.baseUrl(domain,serviceEmail,servicePassword,base64String, 0,80,userId: userId,endPoint: "mrk/")));

      return MakeOrderEntity.fromJson(data,response.statusCode!,response.data);
    } catch (e) {
      throw RemoteDataException();
    }
  }

  @override
  Future<MakeOrderItemsEntity> makeOrderItems({required String orderId, required String paidAmount,required List<CartEntity> products}) async {
    try {



      List<List<CartEntity>> productsChunks = [];

      for(int i = 0; i < products.length ; i += 5 ){

        List<CartEntity> a = products.sublist( i ,(products.length < i + 5)? products.length : i + 5 );

        productsChunks.addAll([a]);

      }

      dynamic data;
      dynamic response;

      for (var element in productsChunks) {

        final productsToMap = element.map((e) => <String,String>{

          "id": e.id.toString(),
          "userid": userId.toString(),
          "order_id": orderId,
          "color_id": "",
          "size_id": "",
          "quantity": e.quantity.toString(),
          "complx_ids": ""
        }).toList();

        String productsJsonString = json.encode(productsToMap);
        String productsBase64String = base64.encode(utf8.encode((productsJsonString)));

        List<Map<String,String>> srvData = [{
          "userid": userId.toString(),
          "order_id": orderId,
          "place_id":"0",
          "paid_amount": paidAmount,
          "paid_method_id":"0",
          "items_count": products.length.toString(),
          "pitems": productsBase64String,
        }];

        String jsonString = json.encode(srvData);
        String base64String = base64.encode(utf8.encode(jsonString));

        response = await client.get(
          AppConsts.baseUrl(domain,serviceEmail,servicePassword,base64String, 0,90,userId: userId,endPoint: "mrk/"),
        );

        Clipboard.setData(ClipboardData(text: AppConsts.baseUrl(domain,serviceEmail,servicePassword,base64String, 0,90,userId: userId,endPoint: "mrk/")));

        data = json.decode(response.data);

      }
      return MakeOrderItemsEntity.fromJson(data,response.statusCode!);

    } catch (e) {
      throw RemoteDataException();
    }
  }




}
