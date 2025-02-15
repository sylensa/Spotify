// To parse this JSON data, do
//
//     final artistModel = artistModelFromJson(jsonString);

import 'dart:convert';

ArtistModel artistModelFromJson(String str) => ArtistModel.fromJson(json.decode(str));

String artistModelToJson(ArtistModel data) => json.encode(data.toJson());

class ArtistModel {
  ArtistData? artists;

  ArtistModel({
    this.artists,
  });

  factory ArtistModel.fromJson(Map<String, dynamic> json) => ArtistModel(
    artists: json["artists"] == null ? null : ArtistData.fromJson(json["artists"]),
  );

  Map<String, dynamic> toJson() => {
    "artists": artists?.toJson(),
  };
}

class ArtistData {
  String? href;
  int? limit;
  String? next;
  int? offset;
  dynamic previous;
  int? total;
  List<Artist>? items;

  ArtistData({
    this.href,
    this.limit,
    this.next,
    this.offset,
    this.previous,
    this.total,
    this.items,
  });

  factory ArtistData.fromJson(Map<String, dynamic> json) => ArtistData(
    href: json["href"],
    limit: json["limit"],
    next: json["next"],
    offset: json["offset"],
    previous: json["previous"],
    total: json["total"],
    items: json["items"] == null ? [] : List<Artist>.from(json["items"]!.map((x) => Artist.fromJson(x))),
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

class Artist {
  ExternalUrls? externalUrls;
  Followers? followers;
  List<String>? genres;
  String? href;
  String? id;
  List<Image>? images;
  String? name;
  int? popularity;
  Type? type;
  String? uri;

  Artist({
    this.externalUrls,
    this.followers,
    this.genres,
    this.href,
    this.id,
    this.images,
    this.name,
    this.popularity,
    this.type,
    this.uri,
  });

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
    externalUrls: json["external_urls"] == null ? null : ExternalUrls.fromJson(json["external_urls"]),
    followers: json["followers"] == null ? null : Followers.fromJson(json["followers"]),
    genres: json["genres"] == null ? [] : List<String>.from(json["genres"]!.map((x) => x)),
    href: json["href"],
    id: json["id"],
    images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
    name: json["name"],
    popularity: json["popularity"],
    type: typeValues.map[json["type"]]!,
    uri: json["uri"],
  );

  Map<String, dynamic> toJson() => {
    "external_urls": externalUrls?.toJson(),
    "followers": followers?.toJson(),
    "genres": genres == null ? [] : List<dynamic>.from(genres!.map((x) => x)),
    "href": href,
    "id": id,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
    "name": name,
    "popularity": popularity,
    "type": typeValues.reverse[type],
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

class Followers {
  dynamic href;
  int? total;

  Followers({
    this.href,
    this.total,
  });

  factory Followers.fromJson(Map<String, dynamic> json) => Followers(
    href: json["href"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "href": href,
    "total": total,
  };
}

class Image {
  String? url;
  int? height;
  int? width;

  Image({
    this.url,
    this.height,
    this.width,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    url: json["url"],
    height: json["height"],
    width: json["width"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "height": height,
    "width": width,
  };
}

enum Type {
  ARTIST
}

final typeValues = EnumValues({
  "artist": Type.ARTIST
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
