import 'dart:convert';
import 'dart:developer';

import 'package:spotify/core/helper/helper.dart';
import 'package:spotify/core/http/http_client_wrapper.dart';
import 'package:spotify/core/shared_preference.dart';
import 'package:spotify/core/utils/app_url.dart';
import 'package:spotify/core/utils/response_codes.dart';
import 'package:spotify/repository/authentication_repo.dart';

class ArtistRepo{
  final HttpClientWrapper _http = HttpClientWrapper();
  final userPreferences = UserPreferences();

  Future<List> searchArtist({String? query, String? type = "artist"}) async {
    try {
      print("tokenss:${await AuthenticationRepo().getSpotifyToken()}");
      var response = await _http.getRequest("${AppUrl.albumArtistSearchUrl}?q=$query&type=$type",);
      log("(response :$response");
      if (response["status"] == AppResponseCodes.success) {

        return [];
      }
    } catch (e) {
      log("error message:${e.toString()}");
    }

    return [];
  }

}