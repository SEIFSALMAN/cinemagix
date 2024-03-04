import 'package:cinemagix/models/movie/movie_model.dart';
import 'package:cinemagix/screens/movie_search_screen.dart';
import 'package:cinemagix/shared/app_constants.dart';
import 'package:cinemagix/shared/components/image_network_component.dart';
import 'package:cinemagix/shared/components/item_pagination_component.dart';
import 'package:cinemagix/shared/components/navigator.dart';
import 'package:cinemagix/shared/components/widget_now_playing_movie_component.dart';
import 'package:cinemagix/shared/components/widget_top_rated_movie_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../shared/components/widget_discover_movie_component.dart';
import 'movies_pagination_screen.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff060720),

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Color(0xff060720),
            centerTitle: true,
            floating: true,
            snap: true,
            title: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Cinemagix",style: TextStyle(color: Colors.white),),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image.asset("assets/logo.png"),
                  ),
                )
              ],
            ),
            actions: [
              IconButton(
                onPressed: () => showSearch(
                  context: context,
                  delegate: MovieSearchPage(),
                ),
                icon: const Icon(Icons.search,color: Colors.white),
              ),
            ],
          ),
          ItemPaginationComponent(
              title: "Discover Movies",
              onPressed: () {
                AppNavigator.customNavigator(
                    context: context,
                    screen: MoviePaginationScreen(type: TypeMovie.discover),
                    finish: false);
              }),
          WidgetDiscoverMovie(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 25,),
                Divider(
                  height: 4,
                  indent: 25,
                  endIndent: 25,
                ),

              ],
            ),
          ),
          ItemPaginationComponent(
            title: "Top Rated Movies",
            onPressed: () {
              AppNavigator.customNavigator(
                  context: context,
                  screen: MoviePaginationScreen(type: TypeMovie.topRated),
                  finish: false);
            },
          ),
          WidgetTopRatedMovie(),
          SliverToBoxAdapter(
            child: Divider(
              height: 4,
              indent: 25,
              endIndent: 25,
            ),
          ),
          ItemPaginationComponent(
              title: "Now Playing Movies",
              onPressed: () {
                AppNavigator.customNavigator(
                    context: context,
                    screen: MoviePaginationScreen(type: TypeMovie.nowPlaying),
                    finish: false);
              }),
          WidgetNowPlayingMovie(),
          SliverToBoxAdapter(
            child: SizedBox(height: 10),
          )
        ],
      ),
    );
  }
}
