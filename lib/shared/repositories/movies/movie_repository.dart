import 'package:cinemagix/models/movie/movie_details_model.dart';
import 'package:cinemagix/models/movie/movie_model.dart';
import 'package:cinemagix/models/movie/movie_trailer_videos_model.dart';
import 'package:dartz/dartz.dart';

abstract class MovieRepository {
  Future<Either<String,MovieResponseModel>> getDiscoverMovies({int page = 1});
  Future<Either<String,MovieResponseModel>> getTopRatedMovies({int page = 1});
  Future<Either<String,MovieResponseModel>> getNowPlayingMovies({int page = 1});
  Future<Either<String,MovieResponseModel>> searchOnMovie({required String query});
  Future<Either<String,MovieDetailModel>> getDetailMovies({required int id});
  Future<Either<String,MovieTrailerVideosModel>> getMovieTrailerVideos({required int id});
}