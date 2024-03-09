import 'package:cinemagix/models/movie/movie_details_model.dart';
import 'package:cinemagix/models/movie/movie_model.dart';
import 'package:cinemagix/models/movie/movie_trailer_videos_model.dart';
import 'package:cinemagix/shared/repositories/tv_series/tvseries_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../models/tv_series/tvseries_details_model.dart';
import '../../../models/tv_series/tvseries_model.dart';
import '../../../models/tv_series/tvseries_trailer_videos_model.dart';

class TVSeriesRepositoryImplementation implements TVSeriesRepository {

  final Dio _dio;
  TVSeriesRepositoryImplementation(this._dio);


  @override
  Future<Either<String, TvSeriesResponseModel>> getDiscoverTVSeries({int page = 1}) async {
    try {
      final result = await _dio.get(
        '/discover/tv',
        queryParameters: {'page': page},
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = TvSeriesResponseModel.fromJson(result.data);
        return Right(model);
      }

      return const Left('Error get discover TV Series');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return const Left('Another error on get discover TV Series');
    }
  }

  @override
  Future<Either<String, TvSeriesResponseModel>> getTopRatedTVSeries({int page = 1}) async {
    try {
      final result = await _dio.get(
        '/tv/top_rated',
        queryParameters: {'page': page},
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = TvSeriesResponseModel.fromJson(result.data);
        return Right(model);
      }

      return const Left('Error get Top Rated TV Series');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return const Left('Another error on get Top Rated TV Series');
    }
  }


  @override
  Future<Either<String, TvSeriesResponseModel>> getAiringNowTVSeries({int page = 1}) async {
    try {
      final result = await _dio.get(
        '/tv/airing_today',
        queryParameters: {'page': page},
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = TvSeriesResponseModel.fromJson(result.data);
        return Right(model);
      }

      return const Left('Error get airing now TV Series');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return const Left('Another error on get airing now TV Series');
    }
  }

  @override
  Future<Either<String, TvSeriesDetailModel>> getDetailTVSeries({required int id}) async {
    try {
      final result = await _dio.get(
        '/tv/$id',
       );

      if (result.statusCode == 200 && result.data != null) {
        final model = TvSeriesDetailModel.fromJson(result.data);
        return Right(model);
      }

      return const Left('Error get details about the TV Series');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return const Left('Another error on get details about the TV Series');
    }
  }

  @override
  Future<Either<String, TvSeriesTrailerVideosModel>> getTVSeriesTrailerVideos({required int id}) async {
    try {
      final result = await _dio.get(
        '/tv/$id/videos',
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = TvSeriesTrailerVideosModel.fromJson(result.data);
        return Right(model);
      }

      return const Left('Error get videos about the TV Series');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return const Left('Another error on get videos about the TV Series');
    }
  }

  @override
  Future<Either<String, TvSeriesResponseModel>> searchOnTVSeries({required String query}) async {
    try {
      final result = await _dio.get(
        '/search/tv',
        queryParameters: {'query' : query}
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = TvSeriesResponseModel.fromJson(result.data);
        return Right(model);
      }

      return const Left('Error while search the TV Series');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return const Left('Another error on searching the TV Series');
    }
  }







}