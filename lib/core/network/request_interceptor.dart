import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:spotify/core/http/http_client_wrapper.dart';
import 'package:spotify/core/shared_preference.dart';
import 'package:spotify/core/utils/app_url.dart';
import 'package:spotify/core/utils/response_codes.dart';
import 'package:spotify/repository/authentication_repo.dart';



 Map<String, String> requestHeaders = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'Authorization': 'Bearer ${UserPreferences.accessToken}',

};

class HeadersInterceptor extends Interceptor {
  HeadersInterceptor(this._headers);

  final Map<String, String> _headers;

  @override
  Future onRequest(RequestOptions options,
      RequestInterceptorHandler handler) async {
    if (!options.headers.containsKey('Authorization')) {
      options.headers.addAll(_headers);
    }
    final token = await UserPreferences().getUserToken();
    print("null token:${options.headers}");
    if (token != null && options.headers.containsKey('Authorization')) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }



  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    print("err.response?.statusCode:${err.response?.statusCode}");
    if (err.response?.statusCode == 401) {
      final refreshed = await _regenerateAccessToken();
      if (refreshed != null) {
        log("UserPreferences.accessToken:${UserPreferences.accessToken}");
        err.requestOptions.headers['Authorization'] =
            'Bearer ${UserPreferences.accessToken}';
        return handler.resolve(await _retry(err.requestOptions));
      }
    }
    return handler.next(err);
  }


  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    print("requestOptions.headers:${requestOptions.headers}");
      final options = Options(
        method: requestOptions.method,
        headers: requestOptions.headers,
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType:ResponseType.json,
      );
      print("res:res${options.method}");
      print("res:res${options.headers}");
      final res =  await Dio().request<dynamic>(requestOptions.path, data: requestOptions.data, queryParameters: requestOptions.queryParameters, options: options);

        return res;
  }

  Future<String?> _regenerateAccessToken() async {
    try {
     String? response = await refreshAccessToken();
      return response;
    } on DioError {
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<String?> refreshAccessToken() async {

   try{
     String? token  = await AuthenticationRepo().getSpotifyToken();
     print("res object refreshToken:$token");
       await UserPreferences().setToken(token ?? "");
       return token;
   }catch(e){
     log("retry error:${e.toString()}");
   }
    return null;
  }
}


