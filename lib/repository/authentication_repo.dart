import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:spotify/core/helper/helper.dart';
import 'package:spotify/core/http/http_client_wrapper.dart';
import 'package:spotify/core/shared_preference.dart';
import 'package:spotify/core/utils/app_url.dart';
import 'package:spotify/core/utils/response_codes.dart';

class AuthenticationRepo{
  final HttpClientWrapper _http = HttpClientWrapper();
  final userPreferences = UserPreferences();
  Future<String?> getSpotifyAccessToken() async {
    String credentials = base64Encode(utf8.encode('$clientId:$clientSecret'));
    Map<String, String> headers = {
      'Authorization': 'Basic $credentials',
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    Map<String, String> body = {
      'grant_type': 'client_credentials',
    };
    try {
      final response = await post(
        Uri.parse(AppUrl.spotifyTokenUrl),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        String? token = responseData['access_token'];
        await userPreferences.setToken(token ?? "");
        return token;
      } else {
        print('Error: ${response.statusCode}, ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }




}





