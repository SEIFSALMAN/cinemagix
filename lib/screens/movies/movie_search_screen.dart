import 'package:cinemagix/screens/movies/movie_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../shared/provider/movies/movie_search_provider.dart';
import '../../shared/widgets/image_network_widget.dart';
import '../../shared/widgets/navigator.dart';

class MovieSearchScreen extends SearchDelegate {
  @override
  String? get searchFieldLabel => "Search Movies..";

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
        context.read<MovieSearchProvider>().search(context, query: query);
      }
    });

    return Consumer<MovieSearchProvider>(
      builder: (_, provider, __) {
        if (query.isEmpty) {
          return const Center(child: Text("Search Movies",style: TextStyle(color: Colors.white),));
        }

        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator(color: Colors.white,));
        }

        if (provider.movies.isEmpty) {
          return const Center(child: Text("Movies Not Found",style: TextStyle(color: Colors.white),));
        }

        if (provider.movies.isNotEmpty) {
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemBuilder: (_, index) {
              final movie = provider.movies[index];
              return Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white,width: 0.1),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Row(
                      children: [
                        ImageWidget(
                          imagePath: movie.posterPath,
                          height: 120,
                          width: 80,
                          radius: 10,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                movie.overview,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white60,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          AppNavigator.customNavigator(context: context, screen: MovieDetailScreen(id: movie.id), finish: false);
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemCount: provider.movies.length,
          );
        }

        return const Center(child: Text("Another Error on search movies",style: TextStyle(color: Colors.white),));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox();
  }
}