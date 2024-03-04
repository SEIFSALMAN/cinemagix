import 'package:cinemagix/models/repostories/movie_repository_implementation.dart';
import 'package:cinemagix/screens/movies_screen.dart';
import 'package:cinemagix/shared/app_constants.dart';
import 'package:cinemagix/shared/injector.dart';
import 'package:cinemagix/shared/provider/movie_get_discover_provider.dart';
import 'package:cinemagix/shared/provider/movie_get_now_playing_provider.dart';
import 'package:cinemagix/shared/provider/movie_get_top_rated_provider.dart';
import 'package:cinemagix/shared/provider/movie_search_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'models/repostories/movie_repository.dart';

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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MovieScreen(),
      ),
    );
  }
}
