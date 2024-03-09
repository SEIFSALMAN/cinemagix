import 'package:cinemagix/screens/movies/movies_screen.dart';
import 'package:cinemagix/shared/injector.dart';
import 'package:cinemagix/shared/provider/actor/actor_search_provider.dart';
import 'package:cinemagix/shared/provider/actor/get_actors_provider.dart';
import 'package:cinemagix/shared/provider/actor/get_detail_actor_provider.dart';
import 'package:cinemagix/shared/provider/movies/movie_get_detail_provider.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'shared/provider/movies/movie_get_discover_provider.dart';


void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  setup();
  runApp(MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => sl<MovieGetDiscoverProvider>()),
        ChangeNotifierProvider(
            create: (context) => sl<MovieGetTopRatedProvider>()),
        ChangeNotifierProvider(
            create: (context) => sl<MovieGetNowPlayingProvider>()),
        ChangeNotifierProvider(
            create: (context) => sl<MovieSearchProvider>()),
        ChangeNotifierProvider(
            create: (context) => sl<MovieGetVideosProvider>()),
        ChangeNotifierProvider(
            create: (context) => sl<MovieGetDetailProvider>()),
        ChangeNotifierProvider(
            create: (context) => sl<TVSeriesGetDiscoverProvider>()),
        ChangeNotifierProvider(
            create: (context) => sl<TVSeriesGetTopRatedProvider>()),
        ChangeNotifierProvider(
            create: (context) => sl<TVSeriesGetAiringNowProvider>()),
        ChangeNotifierProvider(
            create: (context) => sl<TVSeriesSearchProvider>()),
        ChangeNotifierProvider(
            create: (context) => sl<TVSeriesGetVideosProvider>()),
        ChangeNotifierProvider(
            create: (context) => sl<TVSeriesGetDetailProvider>()),
        ChangeNotifierProvider(
            create: (context) => sl<GetActorsProvider>()),
        ChangeNotifierProvider(
            create: (context) => sl<ActorGetDetailProvider>()),
        ChangeNotifierProvider(
            create: (context) => sl<ActorSearchProvider>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MovieScreen(),
      ),
    );
  }
}
