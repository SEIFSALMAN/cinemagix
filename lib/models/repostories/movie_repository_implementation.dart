import 'package:cinemagix/models/movie/movie_details_model.dart';
import 'package:cinemagix/models/movie/movie_model.dart';
import 'package:cinemagix/models/movie/movie_video_model.dart';
import 'package:cinemagix/models/repostories/movie_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class MovieRepositoryImplementation implements MovieRepository {

  final Dio _dio;
  MovieRepositoryImplementation(this._dio);


  @override
  Future<Either<String, MovieResponseModel>> getDiscover({int page = 1}) async {
    try {
      final result = await _dio.get(
        '/discover/movie',
        queryParameters: {'page': page},
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromMap(result.data);
        return Right(model);
      }

      return const Left('Error get discover movies');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return const Left('Another error on get discover movies');
    }
  }

  @override
  Future<Either<String, MovieResponseModel>> getTopRated({int page = 1}) async {
    try {
      final result = await _dio.get(
        '/movie/top_rated',
        queryParameters: {'page': page},
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromMap(result.data);
        return Right(model);
      }

      return const Left('Error get Top Rated movies');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return const Left('Another error on get Top Rated movies');
    }
  }


  @override
  Future<Either<String, MovieResponseModel>> getNowPlaying({int page = 1}) async {
    try {
      final result = await _dio.get(
        '/movie/now_playing',
        queryParameters: {'page': page},
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromMap(result.data);
        return Right(model);
      }

      return const Left('Error get now playing movies');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return const Left('Another error on get now playing movies');
    }
  }

  @override
  Future<Either<String, MovieDetailModel>> getDetail({required int id}) async {
    try {
      final result = await _dio.get(
        '/movie/$id',
       );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieDetailModel.fromMap(result.data);
        return Right(model);
      }

      return const Left('Error get details about the movie');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return const Left('Another error on get details about the movie');
    }
  }

  @override
  Future<Either<String, MovieVideosModel>> getVideos({required int id}) async {
    try {
      final result = await _dio.get(
        '/movie/$id/videos',
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieVideosModel.fromMap(result.data);
        return Right(model);
      }

      return const Left('Error get videos about the movie');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return const Left('Another error on get videos about the movie');
    }
  }

  @override
  Future<Either<String, MovieResponseModel>> search({required String query}) async {
    try {
      final result = await _dio.get(
        '/search/movie',
        queryParameters: {'query' : query}
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromMap(result.data);
        return Right(model);
      }

      return const Left('Error while search the movie');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return const Left('Another error on searching the movie');
    }
  }







}