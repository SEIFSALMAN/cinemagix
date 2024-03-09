import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../screens/movies/movie_detail_screen.dart';
import '../../provider/movies/movie_get_top_rated_provider.dart';
import '../image_network_widget.dart';
import '../navigator.dart';

class TopRatedMovieWidget extends StatefulWidget {
  const TopRatedMovieWidget({super.key});

  @override
  State<TopRatedMovieWidget> createState() => _TopRatedMovieWidgetState();
}

class _TopRatedMovieWidgetState extends State<TopRatedMovieWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieGetTopRatedProvider>().getTopRated(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 270,
        child: Consumer<MovieGetTopRatedProvider>(
          builder: (_, provider, __) {
            if (provider.isLoading) {
              return Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  height: 200,
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
              return ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.movies.length,
                  separatorBuilder: (_, __) => SizedBox(width: 15),
                  itemBuilder: (_, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: ()=> AppNavigator.customNavigator(context: context, screen: MovieDetailScreen(id: provider.movies[index].id), finish: false),
                          child: ImageWidget(
                              imagePath: provider.movies[index].posterPath,
                              width: 120,
                              height: 200,
                              radius: 10),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 120,
                            height: 40,
                            child: Text(provider.movies[index].title,style: TextStyle(color: Colors.white,fontSize: 12),textAlign: TextAlign.center,maxLines: 2,)
                        )
                        // Text(provider.movies[index].title)
                      ],
                    );
                  });
            }
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              height: 300,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                  child: Text(
                "Not found top rated movies",
                style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
              )),
            );
          },
        ),
      ),
    );
  }
}
