// To parse this JSON data, do
//
//     final albumModels = albumModelsFromJson(jsonString);

import 'dart:convert';

AlbumModels albumModelsFromJson(String str) => AlbumModels.fromJson(json.decode(str));

String albumModelsToJson(AlbumModels data) => json.encode(data.toJson());

class AlbumModels {
  AlbumData? albums;

  AlbumModels({
    this.albums,
  });

  factory AlbumModels.fromJson(Map<String, dynamic> json) => AlbumModels(
    albums: json["albums"] == null ? null : AlbumData.fromJson(json["albums"]),
  );

  Map<String, dynamic> toJson() => {
    "albums": albums?.toJson(),
  };
}

class AlbumData {
  String? href;
  int? limit;
  String? next;
  int? offset;
  dynamic previous;
  int? total;
  List<Album>? items;

  AlbumData({
    this.href,
    this.limit,
    this.next,
    this.offset,
    this.previous,
    this.total,
    this.items,
  });

  factory AlbumData.fromJson(Map<String, dynamic> json) => AlbumData(
    href: json["href"],
    limit: json["limit"],
    next: json["next"],
    offset: json["offset"],
    previous: json["previous"],
    total: json["total"],
    items: json["items"] == null ? [] : List<Album>.from(json["items"]!.map((x) => Album.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "href": href,
    "limit": limit,
    "next": next,
    "offset": offset,
    "previous": previous,
    "total": total,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class Album {
  AlbumTypeEnum? albumType;
  int? totalTracks;
  List<String>? availableMarkets;
  ExternalUrls? externalUrls;
  String? href;
  String? id;
  List<Image>? images;
  String? name;
  String? releaseDate;
  ReleaseDatePrecision? releaseDatePrecision;
  AlbumTypeEnum? type;
  String? uri;
  List<Artist>? artists;

  Album({
    this.albumType,
    this.totalTracks,
    this.availableMarkets,
    this.externalUrls,
    this.href,
    this.id,
    this.images,
    this.name,
    this.releaseDate,
    this.releaseDatePrecision,
    this.type,
    this.uri,
    this.artists,
  });

  factory Album.fromJson(Map<String, dynamic> json) => Album(
    albumType: albumTypeEnumValues.map[json["album_type"]]!,
    totalTracks: json["total_tracks"],
    availableMarkets: json["available_markets"] == null ? [] : List<String>.from(json["available_markets"]!.map((x) => x)),
    externalUrls: json["external_urls"] == null ? null : ExternalUrls.fromJson(json["external_urls"]),
    href: json["href"],
    id: json["id"],
    images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
    name: json["name"],
    releaseDate: json["release_date"],
    releaseDatePrecision: releaseDatePrecisionValues.map[json["release_date_precision"]]!,
    type: albumTypeEnumValues.map[json["type"]]!,
    uri: json["uri"],
    artists: json["artists"] == null ? [] : List<Artist>.from(json["artists"]!.map((x) => Artist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "album_type": albumTypeEnumValues.reverse[albumType],
    "total_tracks": totalTracks,
    "available_markets": availableMarkets == null ? [] : List<dynamic>.from(availableMarkets!.map((x) => x)),
    "external_urls": externalUrls?.toJson(),
    "href": href,
    "id": id,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
    "name": name,
    "release_date": releaseDate,
    "release_date_precision": releaseDatePrecisionValues.reverse[releaseDatePrecision],
    "type": albumTypeEnumValues.reverse[type],
    "uri": uri,
    "artists": artists == null ? [] : List<dynamic>.from(artists!.map((x) => x.toJson())),
  };
}

enum AlbumTypeEnum {
  ALBUM,
  COMPILATION
}

final albumTypeEnumValues = EnumValues({
  "album": AlbumTypeEnum.ALBUM,
  "compilation": AlbumTypeEnum.COMPILATION
});

class Artist {
  ExternalUrls? externalUrls;
  String? href;
  Id? id;
  Name? name;
  ArtistType? type;
  Uri? uri;

  Artist({
    this.externalUrls,
    this.href,
    this.id,
    this.name,
    this.type,
    this.uri,
  });

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
    externalUrls: json["external_urls"] == null ? null : ExternalUrls.fromJson(json["external_urls"]),
    href: json["href"],
    id: idValues.map[json["id"]]!,
    name: nameValues.map[json["name"]]!,
    type: artistTypeValues.map[json["type"]]!,
    uri: uriValues.map[json["uri"]]!,
  );

  Map<String, dynamic> toJson() => {
    "external_urls": externalUrls?.toJson(),
    "href": href,
    "id": idValues.reverse[id],
    "name": nameValues.reverse[name],
    "type": artistTypeValues.reverse[type],
    "uri": uriValues.reverse[uri],
  };
}

class ExternalUrls {
  String? spotify;

  ExternalUrls({
    this.spotify,
  });

  factory ExternalUrls.fromJson(Map<String, dynamic> json) => ExternalUrls(
    spotify: json["spotify"],
  );

  Map<String, dynamic> toJson() => {
    "spotify": spotify,
  };
}

enum Id {
  THE_0_KB_YTN_QB4_PB1_R_PBBA_F0_P_T4,
  THE_0_LYF_QWJT6_N_XAF_LP_ZQXE9_OF,
  THE_4_VNOM_LT_K_TM9_AHE1_T_ZFM_ZJU,
  THE_71_UR25_ABQ58_VKSQ_JI_NP_GDX
}

final idValues = EnumValues({
  "0kbYTNQb4Pb1rPbbaF0pT4": Id.THE_0_KB_YTN_QB4_PB1_R_PBBA_F0_P_T4,
  "0LyfQWJT6nXafLPZqxe9Of": Id.THE_0_LYF_QWJT6_N_XAF_LP_ZQXE9_OF,
  "4VnomLtKTm9Ahe1tZfmZju": Id.THE_4_VNOM_LT_K_TM9_AHE1_T_ZFM_ZJU,
  "71Ur25Abq58vksqJINpGdx": Id.THE_71_UR25_ABQ58_VKSQ_JI_NP_GDX
});

enum Name {
  JACKIE_WILSON,
  MILES_DAVIS,
  MILES_DAVIS_QUINTET,
  VARIOUS_ARTISTS
}

final nameValues = EnumValues({
  "Jackie Wilson": Name.JACKIE_WILSON,
  "Miles Davis": Name.MILES_DAVIS,
  "Miles Davis Quintet": Name.MILES_DAVIS_QUINTET,
  "Various Artists": Name.VARIOUS_ARTISTS
});

enum ArtistType {
  ARTIST
}

final artistTypeValues = EnumValues({
  "artist": ArtistType.ARTIST
});

enum Uri {
  SPOTIFY_ARTIST_0_KB_YTN_QB4_PB1_R_PBBA_F0_P_T4,
  SPOTIFY_ARTIST_0_LYF_QWJT6_N_XAF_LP_ZQXE9_OF,
  SPOTIFY_ARTIST_4_VNOM_LT_K_TM9_AHE1_T_ZFM_ZJU,
  SPOTIFY_ARTIST_71_UR25_ABQ58_VKSQ_JI_NP_GDX
}

final uriValues = EnumValues({
  "spotify:artist:0kbYTNQb4Pb1rPbbaF0pT4": Uri.SPOTIFY_ARTIST_0_KB_YTN_QB4_PB1_R_PBBA_F0_P_T4,
  "spotify:artist:0LyfQWJT6nXafLPZqxe9Of": Uri.SPOTIFY_ARTIST_0_LYF_QWJT6_N_XAF_LP_ZQXE9_OF,
  "spotify:artist:4VnomLtKTm9Ahe1tZfmZju": Uri.SPOTIFY_ARTIST_4_VNOM_LT_K_TM9_AHE1_T_ZFM_ZJU,
  "spotify:artist:71Ur25Abq58vksqJINpGdx": Uri.SPOTIFY_ARTIST_71_UR25_ABQ58_VKSQ_JI_NP_GDX
});

class Image {
  int? height;
  String? url;
  int? width;

  Image({
    this.height,
    this.url,
    this.width,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    height: json["height"],
    url: json["url"],
    width: json["width"],
  );

  Map<String, dynamic> toJson() => {
    "height": height,
    "url": url,
    "width": width,
  };
}

enum ReleaseDatePrecision {
  DAY,
  MONTH,
  YEAR
}

final releaseDatePrecisionValues = EnumValues({
  "day": ReleaseDatePrecision.DAY,
  "month": ReleaseDatePrecision.MONTH,
  "year": ReleaseDatePrecision.YEAR
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
