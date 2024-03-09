import 'package:cinemagix/models/movie/movie_model.dart';
import 'package:cinemagix/shared/provider/movies/movie_get_top_rated_provider.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import '../../shared/provider/movies/movie_get_discover_provider.dart';
import '../../shared/provider/movies/movie_get_now_playing_provider.dart';
import '../../shared/widgets/navigator.dart';
import '../../shared/widgets/movies_widget/poster_and_backdrop_movie_widget.dart';
import 'movie_detail_screen.dart';

enum TypeMovie {discover , topRated , nowPlaying}


class MoviePaginationScreen extends StatefulWidget {
  const MoviePaginationScreen({super.key,required this.type});
  final TypeMovie type;

  @override
  State<MoviePaginationScreen> createState() => _MoviePaginationScreenState();
}

class _MoviePaginationScreenState extends State<MoviePaginationScreen> {
  final PagingController<int, MovieModel> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {

      switch (widget.type){
        case TypeMovie.discover:
          context.read<MovieGetDiscoverProvider>().getDiscoverWithPaging(context, page: pageKey, pagingController: _pagingController);
          break;
        case TypeMovie.topRated:
          context.read<MovieGetTopRatedProvider>().getTopRatedWithPaging(context, page: pageKey, pagingController: _pagingController);
          break;
          case TypeMovie.nowPlaying:
          context.read<MovieGetNowPlayingProvider>().getNowPlayingWithPaging(context, page: pageKey, pagingController: _pagingController);
          break;
      }

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff060720),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff060720),
        foregroundColor: Colors.white,
        title: Builder(
          builder: (_) {
            switch (widget.type){
              case TypeMovie.discover:
                return Text("Discover Movies");
              case TypeMovie.topRated:
                return Text("Top Rated Movies");
              case TypeMovie.nowPlaying:
                return Text("Now Playing Movies");
            }
          },
        ),
      ),
      body: PagedListView.separated(
        padding: EdgeInsets.all(16),
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<MovieModel>(
          itemBuilder: (context, item, index) {
            return PosterAndBackdropMovieWidget(
              movie: item,
              heightBackDrop: 260,
              widthBackDrop: double.infinity,
              widthPoster: 150,
              heightPoster: 130,
              onTap: ()=> AppNavigator.customNavigator(context: context, screen: MovieDetailScreen(id: item.id), finish: false),
            );
          },
        ),
        separatorBuilder: (context, index) {
          return SizedBox(height: 10);
        },
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
