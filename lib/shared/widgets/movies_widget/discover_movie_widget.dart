import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinemagix/screens/movies/movie_detail_screen.dart';
import 'package:cinemagix/shared/widgets/navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/movies/movie_get_discover_provider.dart';
import 'poster_and_backdrop_movie_widget.dart';

class DiscoverMovieWidget extends StatefulWidget {
  const DiscoverMovieWidget({super.key});

  @override
  State<DiscoverMovieWidget> createState() => _DiscoverMovieWidgetState();
}

class _DiscoverMovieWidgetState extends State<DiscoverMovieWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieGetDiscoverProvider>().getDiscover(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<MovieGetDiscoverProvider>(
        builder: (_, provider, __) {
          if (provider.isLoading) {
            return Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                height: 300,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                    child: Text(
                      "Loading",
                      style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                    )),
              ),
            );
          }

          if (provider.movies.isNotEmpty) {
            return CarouselSlider.builder(
                itemCount: provider.movies.length,
                itemBuilder: (_, index, __) {
                  final movie = provider.movies[index];
                  return PosterAndBackdropMovieWidget(
                    movie: movie,
                    heightBackDrop: 300,
                    widthBackDrop: double.maxFinite,
                    heightPoster: 180,
                    widthPoster: 100,
                    onTap: ()=> AppNavigator.customNavigator(context: context, screen: MovieDetailScreen(id: movie.id), finish: false),
                  );
                },
                options: CarouselOptions(
                    viewportFraction: 0.8,
                    height: 300,
                    reverse: false,
                    autoPlay: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal));
          }
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            height: 300,
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.black12, borderRadius: BorderRadius.circular(12)),
            child: Center(
                child: Text(
                  "Not found Discover movies",
                  style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                )),
          );
        },
      ),
    );
  }
}
