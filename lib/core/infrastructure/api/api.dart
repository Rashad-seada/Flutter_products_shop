import 'package:dio/dio.dart';


abstract class Api {

  get(String baseUrl,{Object? data,Map<String, dynamic>? queryParameters});

  post(String baseUrl,{Object? data,Map<String, dynamic>? queryParameters});

  put(String baseUrl,{Object? data,Map<String, dynamic>? queryParameters});

  delete(String baseUrl,{Object? data,Map<String, dynamic>? queryParameters});

}

class ApiImpl implements Api {

  final Dio client = Dio();

  @override
  Future<Response> delete(String baseUrl,{Object? data,Map<String, dynamic>? queryParameters}) async {
    return await client.delete(
        baseUrl,
        options: Options(
            receiveDataWhenStatusError: true,
            followRedirects: false,
            validateStatus: (status)=> true,
            receiveTimeout: const Duration(seconds: 60)
        ),
        data: data,
        queryParameters: queryParameters,
    );
  }

  @override
  Future<Response> get(String baseUrl,{Object? data,Map<String, dynamic>? queryParameters}) async {
    return await client.get(
      baseUrl,
      options: Options(
          receiveDataWhenStatusError: false,
          followRedirects: false,
          validateStatus: (status)=> true,
          receiveTimeout: const Duration(minutes: 15)
      ),
      data: data,
      queryParameters: queryParameters,
    );
  }

  @override
  Future<Response> post(String baseUrl,{Object? data,Map<String, dynamic>? queryParameters}) async {
    return await client.post(
      baseUrl,
      options: Options(
          receiveDataWhenStatusError: true,
          followRedirects: false,
          validateStatus: (status)=> true,
          receiveTimeout: const Duration(seconds: 60)
      ),
      data: data,
      queryParameters: queryParameters,
    );
  }

  @override
  Future<Response> put(String baseUrl,{Object? data,Map<String, dynamic>? queryParameters}) async {
    return await client.put(
      baseUrl,
      options: Options(
          receiveDataWhenStatusError: true,
          followRedirects: false,
          validateStatus: (status)=> true,
          receiveTimeout: const Duration(seconds: 60)
      ),
      data: data,
      queryParameters: queryParameters,
    );
  }

}