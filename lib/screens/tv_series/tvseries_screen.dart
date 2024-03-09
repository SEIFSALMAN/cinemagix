import 'package:cinemagix/screens/actor/actor_screen.dart';
import 'package:cinemagix/shared/widgets/movies_widget/discover_movie_widget.dart';
import 'package:cinemagix/shared/widgets/title_pagination_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../shared/widgets/movies_widget/now_playing_movie_widget.dart';
import '../../shared/widgets/movies_widget/top_rated_movie_widget.dart';
import '../../shared/widgets/navigator.dart';
import '../../shared/widgets/tv_series_widget/airing_now_tv_widget.dart';
import '../../shared/widgets/tv_series_widget/discover_tv_widget.dart';
import '../../shared/widgets/tv_series_widget/top_rated_tv_widget.dart';
import '../movies/movie_search_screen.dart';
import 'tvseries_search_screen.dart';
import 'tvseries_pagination_screen.dart';

class TVScreen extends StatelessWidget {
  const TVScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2f0101),

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(icon: Icon(CupertinoIcons.arrow_left,color: Colors.white),onPressed: ()=>Navigator.pop(context)),
            backgroundColor: Color(0xff2f0101),
            centerTitle: true,
            floating: true,
            snap: true,
            title: Text("TV Series",style: TextStyle(color: Colors.white)),
            actions: [
              IconButton(
                onPressed: () => showSearch(
                  context: context,
                  delegate: TVSearchScreen(),
                ),
                icon: const Icon(Icons.search,color: Colors.white),
              ),
            ],
          ),
          TitlePaginationWidget(
              title: "Discover TV Series",
              onPressed: () {
                AppNavigator.customNavigator(
                    context: context,
                    screen: TVPaginationScreen(type: TypeTV.discover),
                    finish: false);
              }),
          DiscoverTVSeriesWidget(),
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
            title: "Top Rated TV Series",
            onPressed: () {
              AppNavigator.customNavigator(
                  context: context,
                  screen: TVPaginationScreen(type: TypeTV.topRated),
                  finish: false);
            },
          ),
          TopRatedTVWidget(),
          SliverToBoxAdapter(
            child: Divider(
              height: 4,
              indent: 25,
              endIndent: 25,
            ),
          ),
          TitlePaginationWidget(
              title: "Airing Now TV Series",
              onPressed: () {
                AppNavigator.customNavigator(
                    context: context,
                    screen: TVPaginationScreen(type: TypeTV.airingNow),
                    finish: false);
              }),
          AiringNowTVWidget(),
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
      backgroundColor: Color(0xff2f0101),
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
                title: Text('Movies',style: TextStyle(color: Colors.white),),
              ),
              ListTile(
                title: Text('TV Series',style: TextStyle(color: Colors.white),),
              ),

            ],
          ),
          ExpansionTile(
            title: Text('Movies',style: TextStyle(color: Colors.white),),
            children: <Widget>[
              ListTile(
                title: Text('Popular Movies',style: TextStyle(color: Colors.white),),
              ),
              ListTile(
                title: Text('Now Playing Movies',style: TextStyle(color: Colors.white),),
              ),
              ListTile(
                title: Text('Top Rated Movies',style: TextStyle(color: Colors.white),),
              ),
              ListTile(
                title: Text('Upcoming Movies',style: TextStyle(color: Colors.blue),),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('TV Series',style: TextStyle(color: Colors.white),),
            children: <Widget>[
              ListTile(
                title: Text('On The Air Series',style: TextStyle(color: Colors.white),),
              ),
              ListTile(
                title: Text('Popular Series',style: TextStyle(color: Colors.white),),
              ),
              ListTile(
                title: Text('Top Rated Series',style: TextStyle(color: Colors.white),),
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
