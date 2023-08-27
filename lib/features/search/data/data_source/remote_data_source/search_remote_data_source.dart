import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eng_shop/core/infrastructure/api/api.dart';

import '../../../../../core/config/app_consts.dart';
import '../../../../../core/error/exception.dart';
import '../../../../shop/domain/entity/product_entity.dart';

abstract class SearchRemoteDataSource {

  Future<List<ProductEntity>> searchProducts(String searchTerm);
}


class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {

  String domain;
  String serviceEmail;
  String servicePassword;
  Api client;

  SearchRemoteDataSourceImpl({required this.domain,required this.serviceEmail,required this.servicePassword,required this.client});

  @override
  Future<List<ProductEntity>> searchProducts(String searchTerm) async {
    try {

      List<Map<String,dynamic>> srvData = [{
        "Whr": " AND"
            " etxt LIKE '%$searchTerm%' OR"
            " atxt LIKE '%$searchTerm%' OR"
            " edetails LIKE '%$searchTerm%' OR"
            " adetails LIKE '%$searchTerm%' "
      }];


      String jsonString = json.encode(srvData);
      String base64String = base64.encode(utf8.encode(jsonString));

      Response response = await client.get(
          AppConsts.baseUrl(domain,serviceEmail,servicePassword,base64String,823, 50,endPoint: "list/"),
      );

      List data = json.decode(response.data);

      return data.map((e) => ProductEntity.fromJson(e,response.statusCode!)).toList();

    } catch (e) {
      throw RemoteDataException();
    }
  }

}