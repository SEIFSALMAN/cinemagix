import 'package:cinemagix/shared/provider/actor/actor_search_provider.dart';
import 'package:cinemagix/shared/provider/actor/get_actors_provider.dart';
import 'package:cinemagix/shared/provider/actor/get_detail_actor_provider.dart';
import 'package:cinemagix/shared/provider/movies/movie_get_detail_provider.dart';
import 'package:cinemagix/shared/provider/movies/movie_get_discover_provider.dart';
import 'package:cinemagix/shared/provider/movies/movie_get_now_playing_provider.dart';
import 'package:cinemagix/shared/provider/movies/movie_get_top_rated_provider.dart';
import 'package:cinemagix/shared/provider/movies/movie_get_videos_provider.dart';
import 'package:cinemagix/shared/provider/movies/movie_search_provider.dart';
import 'package:cinemagix/shared/provider/tv_series/tvseries_get_detail_provider.dart';
import 'package:cinemagix/shared/provider/tv_series/tvseries_get_discover_provider.dart';
import 'package:cinemagix/shared/provider/tv_series/tvseries_get_now_playing_provider.dart';
import 'package:cinemagix/shared/provider/tv_series/tvseries_get_top_rated_provider.dart';
import 'package:cinemagix/shared/provider/tv_series/tvseries_get_videos_provider.dart';
import 'package:cinemagix/shared/provider/tv_series/tvseries_search_provider.dart';
import 'package:cinemagix/shared/repositories/actor/actor_repository.dart';
import 'package:cinemagix/shared/repositories/actor/actor_repository_implementation.dart';
import 'package:cinemagix/shared/repositories/movies/movie_repository.dart';
import 'package:cinemagix/shared/repositories/movies/movie_repository_implementation.dart';
import 'package:cinemagix/shared/repositories/tv_series/tvseries_repository.dart';
import 'package:cinemagix/shared/repositories/tv_series/tvseries_repository_implementation.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'app_constants.dart';

final sl = GetIt.instance;

void setup(){

  // Movies Provider
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

  //Series Provider

  sl.registerFactory<TVSeriesGetDiscoverProvider>(
        () => TVSeriesGetDiscoverProvider(sl()),
  );
  sl.registerFactory<TVSeriesGetTopRatedProvider>(
        () => TVSeriesGetTopRatedProvider(sl()),
  );
  sl.registerFactory<TVSeriesGetAiringNowProvider>(
        () => TVSeriesGetAiringNowProvider(sl()),
  );
  sl.registerFactory<TVSeriesGetDetailProvider>(
        () => TVSeriesGetDetailProvider(sl()),
  );
  sl.registerFactory<TVSeriesGetVideosProvider>(
        () => TVSeriesGetVideosProvider(sl()),
  );
  sl.registerFactory<TVSeriesSearchProvider>(
        () => TVSeriesSearchProvider(sl()),
  );
  //Actors Providers
  sl.registerFactory<GetActorsProvider>(
        () => GetActorsProvider(sl()),
  );
  sl.registerFactory<ActorGetDetailProvider>(
        () => ActorGetDetailProvider(sl()),
  );
  sl.registerFactory<ActorSearchProvider>(
        () => ActorSearchProvider(sl()),
  );

  // Register Repository
  sl.registerLazySingleton<MovieRepository>(() => MovieRepositoryImplementation(sl()));
  sl.registerLazySingleton<ActorRepository>(() => ActorRepositoryImplementation(sl()));
  sl.registerLazySingleton<TVSeriesRepository>(() => TVSeriesRepositoryImplementation(sl()));

  //Register Http Client (DIO)
  sl.registerLazySingleton<Dio>(() => Dio(
      BaseOptions(
        baseUrl: AppConstants.baseURL,
        queryParameters: {'api_key': AppConstants.apiKey},
      ),
    ),
  );
}