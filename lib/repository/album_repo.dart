import 'dart:convert';
import 'dart:developer';

import 'package:spotify/core/helper/helper.dart';
import 'package:spotify/core/http/http_client_wrapper.dart';
import 'package:spotify/core/shared_preference.dart';
import 'package:spotify/core/utils/app_url.dart';
import 'package:spotify/core/utils/response_codes.dart';
import 'package:spotify/models/album_model.dart';

class AlbumRepo{
  final HttpClientWrapper _http = HttpClientWrapper();
  final userPreferences = UserPreferences();

  Future<List<Album>> searchAlbum({String? query, String? type = "album"}) async {
    try {
      var response = await _http.getRequest("${AppUrl.albumArtistSearchUrl}?q=$query&type=$type",);
      AlbumData? albumData = AlbumData.fromJson(response["albums"]);
      if (albumData.items?.isNotEmpty == true) {
        return albumData.items ?? [];
      }
    } catch (e) {
      log("error message:${e.toString()}");
    }

    return [];
  }

}