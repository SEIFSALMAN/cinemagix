import 'package:cinemagix/models/movie/movie_model.dart';
import 'package:cinemagix/models/tv_series/tvseries_model.dart';
import 'package:cinemagix/shared/provider/movies/movie_get_top_rated_provider.dart';
import 'package:cinemagix/shared/provider/tv_series/tvseries_get_discover_provider.dart';
import 'package:cinemagix/shared/provider/tv_series/tvseries_get_now_playing_provider.dart';
import 'package:cinemagix/shared/provider/tv_series/tvseries_get_top_rated_provider.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import '../../shared/provider/movies/movie_get_discover_provider.dart';
import '../../shared/provider/movies/movie_get_now_playing_provider.dart';
import '../../shared/widgets/navigator.dart';
import '../../shared/widgets/movies_widget/poster_and_backdrop_movie_widget.dart';
import '../../shared/widgets/tv_series_widget/poster_and_backdrop_tv_widget.dart';
import 'tvseries_detail_screen.dart';

enum TypeTV {discover , topRated , airingNow}


class TVPaginationScreen extends StatefulWidget {
  const TVPaginationScreen({super.key,required this.type});
  final TypeTV type;

  @override
  State<TVPaginationScreen> createState() => _TVPaginationScreenState();
}

class _TVPaginationScreenState extends State<TVPaginationScreen> {
  final PagingController<int, TVSeriesModel> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {

      switch (widget.type){
        case TypeTV.discover:
          context.read<TVSeriesGetDiscoverProvider>().getDiscoverTVWithPaging(context, page: pageKey, pagingController: _pagingController);
          break;
        case TypeTV.topRated:
          context.read<TVSeriesGetTopRatedProvider>().getTopRatedTVWithPaging(context, page: pageKey, pagingController: _pagingController);
          break;
          case TypeTV.airingNow:
          context.read<TVSeriesGetAiringNowProvider>().getAiringNowWithPaging(context, page: pageKey, pagingController: _pagingController);
          break;
      }

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2f0101),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff2f0101),
        foregroundColor: Colors.white,
        title: Builder(
          builder: (_) {
            switch (widget.type){
              case TypeTV.discover:
                return Text("Discover Series");
              case TypeTV.topRated:
                return Text("Top Rated Series");
              case TypeTV.airingNow:
                return Text("Airing Now Series");
            }
          },
        ),
      ),
      body: PagedListView.separated(
        padding: EdgeInsets.all(16),
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<TVSeriesModel>(
          itemBuilder: (context, item, index) {
            return PosterAndBackdropTVWidget(
              seriesModel: item,
              heightBackDrop: 260,
              widthBackDrop: double.infinity,
              widthPoster: 150,
              heightPoster: 130,
              onTap: ()=> AppNavigator.customNavigator(context: context, screen: TVSeriesDetailScreen(id: item.id), finish: false),
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
