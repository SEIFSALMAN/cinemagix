
import 'package:cinemagix/models/tv_series/tvseries_details_model.dart';
import 'package:cinemagix/models/tv_series/tvseries_model.dart';
import 'package:cinemagix/models/tv_series/tvseries_trailer_videos_model.dart';
import 'package:dartz/dartz.dart';

abstract class TVSeriesRepository {
  Future<Either<String,TvSeriesResponseModel>> getDiscoverTVSeries({int page = 1});
  Future<Either<String,TvSeriesResponseModel>> getTopRatedTVSeries({int page = 1});
  Future<Either<String,TvSeriesResponseModel>> getAiringNowTVSeries({int page = 1});
  Future<Either<String,TvSeriesResponseModel>> searchOnTVSeries({required String query});
  Future<Either<String,TvSeriesDetailModel>> getDetailTVSeries({required int id});
  Future<Either<String,TvSeriesTrailerVideosModel>> getTVSeriesTrailerVideos({required int id});
}