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
  String? albumType;
  int? totalTracks;
  List<String>? availableMarkets;
  ExternalUrls? externalUrls;
  String? href;
  String? id;
  List<Image>? images;
  String? name;
  String? releaseDate;
  String? releaseDatePrecision;
  String? type;
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
    albumType: json["album_type"],
    totalTracks: json["total_tracks"],
    availableMarkets: json["available_markets"] == null ? [] : List<String>.from(json["available_markets"]!.map((x) => x)),
    externalUrls: json["external_urls"] == null ? null : ExternalUrls.fromJson(json["external_urls"]),
    href: json["href"],
    id: json["id"],
    images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
    name: json["name"],
    releaseDate: json["release_date"],
    releaseDatePrecision: json["release_date_precision"],
    type: json["type"],
    uri: json["uri"],
    artists: json["artists"] == null ? [] : List<Artist>.from(json["artists"]!.map((x) => Artist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "album_type": albumType,
    "total_tracks": totalTracks,
    "available_markets": availableMarkets == null ? [] : List<dynamic>.from(availableMarkets!.map((x) => x)),
    "external_urls": externalUrls?.toJson(),
    "href": href,
    "id": id,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
    "name": name,
    "release_date": releaseDate,
    "release_date_precision": releaseDatePrecision,
    "type": type,
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
  String? id;
  String? name;
  String? type;
  String? uri;

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
    id:json["id"],
    name: json["name"],
    type: json["type"],
    uri:json["uri"],
  );

  Map<String, dynamic> toJson() => {
    "external_urls": externalUrls?.toJson(),
    "href": href,
    "id": id,
    "name": name,
    "type": type,
    "uri": uri,
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
