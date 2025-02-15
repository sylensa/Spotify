
import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:spotify/core/network/chunk.dart';
import 'package:spotify/core/network/request_interceptor.dart';


import 'generic_http_response.dart';

enum HttpRequestType {
  GET,
  POST,
  PUT,
  DELETE,
  DOWNLOAD,
}

class HttpClientWrapper {

  static var dio =  Dio(BaseOptions(
    connectTimeout: const Duration(minutes: 5),
    receiveTimeout: const Duration(minutes: 5),
  )); //Client

  static String apiUrl(String path, Map<String, dynamic>? queryParams) {
    var uriString = path;
    return Uri.parse(uriString)
        .replace(queryParameters: queryParams)
        .toString();
  }

  static HttpClientWrapper? _instance;

  HttpClientWrapper._internal() {
    //NOTE: The logic below will only be executed if no instance exist
    //So initialization logic can be added here
    _init();
    _instance = this;
  }

  factory HttpClientWrapper() => _instance ?? HttpClientWrapper._internal();

  _init() {
    dio
      ..interceptors.add(InterceptorsWrapper(onRequest: (_, __) {
        (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
            (HttpClient dioClient) {
          dioClient.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
          // return null;
          return dioClient;
        };
        __.next(_);
      }))
      ..interceptors.add(HeadersInterceptor(requestHeaders))
      ..interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 250))
      ..interceptors.add(chuck.getDioInterceptor())
      ..interceptors.add(InterceptorsWrapper(onRequest: (_, __) {
        (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
            (HttpClient dioClient) {
          dioClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
          // return null;
          return dioClient;
        };
        __.next(_);
      }));
  }



  Future<dynamic> _executeHttpRequest(
    HttpRequestType httpRequestType,
    String path,
    Map<String, dynamic>? queryParams, {
    dynamic body,
    Map<String, String>? headers,

  }) async {
    Response? dioResponse;
    GenericHttpResponse response = GenericHttpResponse();

    // final cacheDuration = 1;

    try {
      Options options = Options(
        headers: headers ?? requestHeaders, // Use provided headers or empty
      );
      switch (httpRequestType) {
        case HttpRequestType.GET:

          dioResponse = await dio.get(
            apiUrl(path, queryParams),
            options:options,          );
          break;
        case HttpRequestType.POST:
          dioResponse = await dio.post(
            apiUrl(path, queryParams),
            data: body,
            options:options,
          );
          break;
        case HttpRequestType.PUT:
          dioResponse = await dio.put(
            apiUrl(path, queryParams),
            data: body,
            options:options,
          );
          break;
        case HttpRequestType.DELETE:
          dioResponse = await dio.delete(apiUrl(path, queryParams),data: body,options:options,);
          break;
        case HttpRequestType.DOWNLOAD:
          dioResponse = await dio.get<ResponseBody>(apiUrl(path, queryParams),
              options: Options(responseType: ResponseType.stream));
          break;
        default:
          dioResponse = await dio.get(
            apiUrl(path, queryParams),
            // options: buildCacheOptions(Duration(days: cacheDuration)),
          );
          break;
      }
      //Request was a success
      response.success = true;
      response.body = dioResponse.data;
      response.status = dioResponse.statusCode;
      // print("response.body:${response.body}");
      // print("dioResponse.statusCode:${dioResponse.statusCode}");
      // print("dioResponse.headers:${dioResponse.headers}");
      // print("pathpath:${path}");

      return response.body;
    } on TimeoutException catch (e) {
      // Handle timeout
      print("Timeout Error: ${e.message}");
      log("retry error:${e.toString()}");
      response.body = dioResponse?.data;
      return response.body;
    } catch (e) {
      if (e is DioError) {
        print('Dio error: ${e.message}');
        if (e.response != null) {
          // If the response is available, you can access the data
          print('Dio error response: ${e.response?.data}');
          response.body = e.response?.data;
          // Pass the response data to the user or handle it as needed
        }
      } else {
        log("error body:${dioResponse?.data}");
        log("retry error:${e.toString()}");
        response.body = dioResponse?.data;
      }
      return response.body;
    }
  }

  Future<dynamic> getRequest(String path,
      {Map<String, dynamic>? queryParams,  Map<String, String>? headers,}) async {
    return await _executeHttpRequest(HttpRequestType.GET, path, queryParams,headers: headers);
  }

  Future<dynamic> postRequest(String path,dynamic body,{Map<String, String>? headers,}) async {
    log("path:$path");
    log("body:$body");
    log("headersheaders:$headers");
    var quarams;
    return await _executeHttpRequest(HttpRequestType.POST, path,quarams,body: body,headers: headers);
  }

  Future<dynamic> putRequest(String path, dynamic body,{  Map<String, String>? headers,}) async {
    var queryParams;
    return await _executeHttpRequest(HttpRequestType.PUT, path, queryParams,
        body: body,headers: headers);
  }

  Future<dynamic> deleteRequest(String path,
      {Map<String, dynamic>? queryParams, dynamic body,  Map<String, String>? headers,}) async {
    return await _executeHttpRequest(HttpRequestType.DELETE, path, queryParams,body: body,headers: headers);
  }

  Future<Response> downloadRequest(String path,
      {Map<String, dynamic>? queryParams}) async {
    return dio.get<Uint8List>(apiUrl(path, queryParams),
        options: Options(responseType: ResponseType.bytes));
  }

}
