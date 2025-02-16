
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:spotify/main.dart';
import 'package:spotify/models/album_model.dart' hide Artist;
import 'package:spotify/models/artist_model.dart';
import 'package:spotify/repository/album_repo.dart';
import 'package:spotify/repository/artist_repo.dart';
import 'package:spotify/repository/authentication_repo.dart';

void main() {
  group('Spotify API Tests', () {
    test('Fetch Spotify token', () async {
      final String? tokenString = await AuthenticationRepo().getSpotifyAccessToken();
      expect(tokenString, isNotNull);
    });

    test('Search albums', () async {
      List<Album> albums = await AlbumRepo().searchAlbum(query: "gnx",type: "album");
      expect(albums, isNotEmpty);
    });

    test('Search artists', () async {
      List<Artist> artists = await ArtistRepo().searchArtist(query: "gnx",type: "album");
      expect(artists, isNotEmpty);
    });
  });
}
