import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:spotify/core/helper/helper.dart';
import 'package:spotify/core/http/http_client_wrapper.dart';
import 'package:spotify/core/shared_preference.dart';
import 'package:spotify/core/utils/app_url.dart';
import 'package:spotify/core/utils/response_codes.dart';

class AuthenticationRepo{
  final HttpClientWrapper _http = HttpClientWrapper();
  final userPreferences = UserPreferences();

 Future<String?> getSpotifyToken() async {
    try {
      final credentials = base64Encode(
        utf8.encode('${Uri.encodeComponent(clientId)}:${Uri.encodeComponent(clientSecret)}'), // Combine with a colon
      );
      var response = await _http.postRequest(AppUrl.spotifyTokenUrl,
        {"grant_type": "client_credentials",
          "client_id": clientId,
          "client_secret":clientSecret,
        },

        headers: {
        'Authorization': 'Basic $credentials',
        'Content-Type': 'application/x-www-form-urlencoded',

        },
      );
      log("(response :$response");
      if (response["status"] == AppResponseCodes.success) {
        String? token = response['data']["toke"];
        await userPreferences.setToken(token ?? "");
        return token;
      }
    } catch (e) {
     log("error message:${e.toString()}");
    }

    return null;
  }




}