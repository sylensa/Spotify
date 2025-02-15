import 'package:spotify/flavor_settings.dart';


class AppUrl {
  static const String liveBaseURL = "https://api.spotify.com/v1";
  static const String qaBaseURL = "https://api.spotify.com/v1";
  static const String spotifyTokenUrl = "https://accounts.spotify.com/api/token";


  static String baseURL = FlavorSettings.apiBaseUrl;
  static String albumArtistSearchUrl = "$baseURL/search";

}

