import 'dart:developer';

import 'package:cinemagix/screens/actor/actor_detail_screen.dart';
import 'package:cinemagix/screens/movies/movie_detail_screen.dart';
import 'package:cinemagix/shared/provider/actor/actor_search_provider.dart';
import 'package:cinemagix/shared/provider/actor/actor_search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../shared/provider/movies/movie_search_provider.dart';
import '../../shared/widgets/image_network_widget.dart';
import '../../shared/widgets/navigator.dart';

class ActorSearchScreen extends SearchDelegate {
  @override
  String? get searchFieldLabel => "Search Actors..";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = "",
        icon: const Icon(Icons.clear,
            color: Colors.white
        ),
      ),
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.white),
          hintStyle: TextStyle(color: Colors.grey)
      ),
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.white),
        // foregroundColor: Colors.white,
        backgroundColor: Color(0xff060720),
        elevation: 0.5,
      ),
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (query.isNotEmpty) {
        context.read<ActorSearchProvider>().searchOnActor(context, query: query);
      }
    });

    return Consumer<ActorSearchProvider>(
      builder: (_, provider, __) {
        if (query.isEmpty) {
          return const Center(child: Text("Search Actors",style: TextStyle(color: Colors.white),));
        }

        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator(color: Colors.white,));
        }

        if (provider.actor.isEmpty) {
          return const Center(child: Text("Actor Not Found",style: TextStyle(color: Colors.white),));
        }

        if (provider.actor.isNotEmpty) {
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemBuilder: (_, index) {
              final actor = provider.actor[index];
              log(actor.toString());
              return Stack(
                children: [
                  ImageWidget(
                      imagePath:
                      actor.profilePath,
                      width: 500,
                      height: 500,
                      radius: 10),
                  Container(
                    height: 500,
                    width: 500,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black87])),
                  ),
                  Positioned(
                    left: 20,
                    bottom: 20,
                    right: 50,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          actor.name,
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),

                      ],
                    ),
                  ),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                          onTap: (){
                            AppNavigator.customNavigator(context: context, screen: ActorDetailScreen(id: actor.id), finish: false);
                          }
                      ),
                    ),)
                ],
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemCount: provider.actor.length,
          );
        }

        return const Center(child: Text("Another Error on search actors",style: TextStyle(color: Colors.white),));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox();
  }
}