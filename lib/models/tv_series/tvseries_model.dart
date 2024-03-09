// To parse this JSON data, do
//
//     final tvSeriesResponseModel = tvSeriesResponseModelFromJson(jsonString);

import 'dart:convert';

TvSeriesResponseModel tvSeriesResponseModelFromJson(String str) => TvSeriesResponseModel.fromJson(json.decode(str));


class TvSeriesResponseModel {
  int page;
  List<TVSeriesModel> results;
  int totalPages;
  int totalResults;

  TvSeriesResponseModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TvSeriesResponseModel.fromJson(Map<String, dynamic> json) => TvSeriesResponseModel(
    page: json["page"],
    results: List<TVSeriesModel>.from(json["results"].map((x) => TVSeriesModel.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

}

class TVSeriesModel {
  bool adult;
  String? backdropPath;
  List<int> genreIds;
  int id;
  List<String> originCountry;
  String originalLanguage;
  String originalName;
  String overview;
  double popularity;
  String posterPath;
  String name;
  double voteAverage;
  int voteCount;

  TVSeriesModel({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TVSeriesModel.fromJson(Map<String, dynamic> json) => TVSeriesModel(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    id: json["id"],
    originCountry: List<String>.from(json["origin_country"].map((x) => x)),
    originalLanguage: json["original_language"],
    originalName: json["original_name"],
    overview: json["overview"],
    popularity: json["popularity"]?.toDouble(),
    posterPath: json["poster_path"] ?? "",
    name: json["name"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
  );

}
