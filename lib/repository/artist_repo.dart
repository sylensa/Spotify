import 'dart:convert';
import 'dart:developer';

import 'package:spotify/core/helper/helper.dart';
import 'package:spotify/core/http/http_client_wrapper.dart';
import 'package:spotify/core/shared_preference.dart';
import 'package:spotify/core/utils/app_url.dart';
import 'package:spotify/core/utils/response_codes.dart';
import 'package:spotify/models/artist_model.dart';
import 'package:spotify/repository/authentication_repo.dart';

class ArtistRepo{
  final HttpClientWrapper _http = HttpClientWrapper();
  final userPreferences = UserPreferences();

  Future<List<Artist>> searchArtist({String? query, String? type = "artist"}) async {
    try {
      var response = await _http.getRequest("${AppUrl.albumArtistSearchUrl}?q=$query&type=$type",);
      log("response :$response");
      ArtistModel artistModel = ArtistModel.fromJson(response);
      if (artistModel.artists?.items?.isNotEmpty == true) {
        return artistModel.artists!.items!;
      }
    } catch (e) {
      log("error message:${e.toString()}");
    }

    return [];
  }

}