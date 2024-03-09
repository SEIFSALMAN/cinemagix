// To parse this JSON data, do
//
//     final actorResponseModel = actorResponseModelFromJson(jsonString);

import 'dart:convert';

ActorResponseModel actorResponseModelFromJson(String str) => ActorResponseModel.fromJson(json.decode(str));


class ActorResponseModel {
  int page;
  List<ActorModel> results;
  int totalPages;
  int totalResults;

  ActorResponseModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory ActorResponseModel.fromJson(Map<String, dynamic> json) => ActorResponseModel(
    page: json["page"],
    results: List<ActorModel>.from(json["results"].map((x) => ActorModel.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

}

class ActorModel {
  int gender;
  int id;
  String name;
  String originalName;
  String profilePath;
  List<KnownFor> knownFor;

  ActorModel({
    required this.gender,
    required this.id,
    required this.name,
    required this.originalName,
    required this.profilePath,
    required this.knownFor,
  });

  factory ActorModel.fromJson(Map<String, dynamic> json) => ActorModel(
    gender: json["gender"],
    id: json["id"],
    name: json["name"],
    originalName: json["original_name"],
    profilePath: json["profile_path"] ?? "",
    knownFor: List<KnownFor>.from(json["known_for"].map((x) => KnownFor.fromJson(x))),
  );

}

class KnownFor {
  bool adult;
  String? backdropPath;
  int id;
  String? title;
  String? originalTitle;
  String overview;
  String posterPath;
  MediaType mediaType;
  List<int> genreIds;
  double popularity;
  DateTime? releaseDate;
  double voteAverage;
  int voteCount;
  String? name;
  String? originalName;
  DateTime? firstAirDate;
  List<String>? originCountry;

  KnownFor({
    required this.adult,
    required this.backdropPath,
    required this.id,
    this.title,
    this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.genreIds,
    required this.popularity,
    this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    this.name,
    this.originalName,
    this.firstAirDate,
    this.originCountry,
  });

  factory KnownFor.fromJson(Map<String, dynamic> json) => KnownFor(
    adult: json["adult"],
    backdropPath: json["backdrop_path"] ?? "",
    id: json["id"],
    title: json["title"],
    originalTitle: json["original_title"],
    overview: json["overview"],
    posterPath: json["poster_path"] ?? "",
    mediaType: mediaTypeValues.map[json["media_type"]]!,
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    popularity: json["popularity"]?.toDouble(),
    releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
    name: json["name"],
    originalName: json["original_name"],
    firstAirDate: json["first_air_date"] == null ? null : DateTime.parse(json["first_air_date"]),
    originCountry: json["origin_country"] == null ? [] : List<String>.from(json["origin_country"]!.map((x) => x)),
  );

}

enum MediaType {
  MOVIE,
  TV
}

final mediaTypeValues = EnumValues({
  "movie": MediaType.MOVIE,
  "tv": MediaType.TV
});

enum OriginalLanguage {
  EN
}

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN
});

enum KnownForDepartment {
  ACTING
}

final knownForDepartmentValues = EnumValues({
  "Acting": KnownForDepartment.ACTING
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
