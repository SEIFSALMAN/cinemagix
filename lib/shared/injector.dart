import 'package:cinemagix/models/repostories/movie_repository_implementation.dart';
import 'package:cinemagix/shared/provider/movie_get_detail_provider.dart';
import 'package:cinemagix/shared/provider/movie_get_discover_provider.dart';
import 'package:cinemagix/shared/provider/movie_get_now_playing_provider.dart';
import 'package:cinemagix/shared/provider/movie_get_top_rated_provider.dart';
import 'package:cinemagix/shared/provider/movie_get_videos_provider.dart';
import 'package:cinemagix/shared/provider/movie_search_provider.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../models/repostories/movie_repository.dart';
import 'app_constants.dart';

final sl = GetIt.instance;

void setup(){

  // Register Provider
  sl.registerFactory<MovieGetDiscoverProvider>(
        () => MovieGetDiscoverProvider(sl()),
  );
  sl.registerFactory<MovieGetTopRatedProvider>(
        () => MovieGetTopRatedProvider(sl()),
  );
  sl.registerFactory<MovieGetNowPlayingProvider>(
        () => MovieGetNowPlayingProvider(sl()),
  );
  sl.registerFactory<MovieGetDetailProvider>(
        () => MovieGetDetailProvider(sl()),
  );
  sl.registerFactory<MovieGetVideosProvider>(
        () => MovieGetVideosProvider(sl()),
  );
  sl.registerFactory<MovieSearchProvider>(
        () => MovieSearchProvider(sl()),
  );

  // Register Repository
  sl.registerLazySingleton<MovieRepository>(() => MovieRepositoryImplementation(sl()));

  //Register Http Client (DIO)
  sl.registerLazySingleton<Dio>(() => Dio(
      BaseOptions(
        baseUrl: AppConstants.baseURL,
        queryParameters: {'api_key': AppConstants.apiKey},
      ),
    ),
  );
}