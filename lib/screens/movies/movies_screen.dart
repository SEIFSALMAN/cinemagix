import 'package:cinemagix/screens/actor/actor_screen.dart';
import 'package:cinemagix/screens/tv_series/tvseries_pagination_screen.dart';
import 'package:cinemagix/screens/tv_series/tvseries_screen.dart';
import 'package:cinemagix/shared/widgets/movies_widget/discover_movie_widget.dart';
import 'package:cinemagix/shared/widgets/title_pagination_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../shared/widgets/movies_widget/now_playing_movie_widget.dart';
import '../../shared/widgets/movies_widget/top_rated_movie_widget.dart';
import '../../shared/widgets/navigator.dart';
import 'movie_search_screen.dart';
import 'movies_pagination_screen.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff060720),
      drawer: MyDrawer(),

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Builder(
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.menu_open,
                      color: Colors.white,
                      size: 25,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    tooltip:
                    MaterialLocalizations.of(context).openAppDrawerTooltip,
                  ),
                );
              },
            ),
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
                  delegate: MovieSearchScreen(),
                ),
                icon: const Icon(Icons.search,color: Colors.white),
              ),
            ],
          ),
          TitlePaginationWidget(
              title: "Discover Movies",
              onPressed: () {
                AppNavigator.customNavigator(
                    context: context,
                    screen: MoviePaginationScreen(type: TypeMovie.discover),
                    finish: false);
              }),
          DiscoverMovieWidget(),
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
          TitlePaginationWidget(
            title: "Top Rated Movies",
            onPressed: () {
              AppNavigator.customNavigator(
                  context: context,
                  screen: MoviePaginationScreen(type: TypeMovie.topRated),
                  finish: false);
            },
          ),
          TopRatedMovieWidget(),
          SliverToBoxAdapter(
            child: Divider(
              height: 4,
              indent: 25,
              endIndent: 25,
            ),
          ),
          TitlePaginationWidget(
              title: "Now Playing",
              onPressed: () {
                AppNavigator.customNavigator(
                    context: context,
                    screen: MoviePaginationScreen(type: TypeMovie.nowPlaying),
                    finish: false);
              }),
          NowPlayingMovieWidget(),
          SliverToBoxAdapter(
            child: SizedBox(height: 10),
          )
        ],
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xff060720),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.white30,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/logo.png",height: 50,width: 50),
                SizedBox(width: 10),
                Text(
                  'Cinemagix',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                  ),
                ),
              ],
            ),
          ),
          ExpansionTile(
            title: Text('Discover',style: TextStyle(color: Colors.white),),
            children: <Widget>[
              ListTile(
                title: Text('Movies',style: TextStyle(color: Colors.grey.shade300),),
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                },
              ),
              ListTile(
                title: Text('TV Series',style: TextStyle(color: Colors.grey.shade300),),
                tileColor: Color(0xff2f0101),
                onTap: ()=> AppNavigator.customNavigator(context: context, screen: TVScreen(), finish: false),
              ),

            ],
          ),
          ExpansionTile(
            title: Text('Movies',style: TextStyle(color: Colors.white),),
            children: <Widget>[
              ListTile(
                title: Text('Discover Movies',style: TextStyle(color: Colors.grey.shade300),),
                onTap: ()=> AppNavigator.customNavigator(context: context, screen: MoviePaginationScreen(type: TypeMovie.discover), finish: false),
              ), ListTile(
                title: Text('Now Playing Movies',style: TextStyle(color: Colors.grey.shade300),),
                onTap: ()=> AppNavigator.customNavigator(context: context, screen: MoviePaginationScreen(type: TypeMovie.nowPlaying), finish: false),
              ),
              ListTile(
                title: Text('Top Rated Movies',style: TextStyle(color: Colors.grey.shade300),),
                onTap: ()=> AppNavigator.customNavigator(context: context, screen: MoviePaginationScreen(type: TypeMovie.topRated), finish: false),
              ),

            ],
          ),
          ExpansionTile(
            backgroundColor: Color(0xff2f0101),
            title: Text('TV Series',style: TextStyle(color: Colors.white),),
            children: <Widget>[
              ListTile(
                title: Text('On The Air Series',style: TextStyle(color: Colors.grey.shade300),),
                onTap: ()=> AppNavigator.customNavigator(context: context, screen: TVPaginationScreen(type: TypeTV.airingNow), finish: false),

              ),
              ListTile(
                title: Text('Discover Series',style: TextStyle(color: Colors.grey.shade300),),
                onTap: ()=> AppNavigator.customNavigator(context: context, screen: TVPaginationScreen(type: TypeTV.discover), finish: false),

              ),
              ListTile(
                title: Text('Top Rated Series',style: TextStyle(color: Colors.grey.shade300),),
                onTap: ()=> AppNavigator.customNavigator(context: context, screen: TVPaginationScreen(type: TypeTV.topRated), finish: false),

              ),
            ],
          ),
          ListTile(
            title: Text('Popular Actors',style: TextStyle(color: Colors.white),),
            onTap: () {
              // Add your action here
              AppNavigator.customNavigator(context: context, screen: ActorScreen(), finish: false);
            },
          ),
        ],
      ),
    );
  }
}
