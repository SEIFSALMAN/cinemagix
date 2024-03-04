import 'package:cinemagix/shared/components/image_network_component.dart';
import 'package:cinemagix/shared/components/navigator.dart';
import 'package:cinemagix/shared/components/youtube_player_component.dart';
import 'package:cinemagix/shared/provider/movie_get_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../shared/components/item_movie_component.dart';
import '../shared/components/webview_component.dart';
import '../shared/injector.dart';
import '../shared/provider/movie_get_videos_provider.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              sl<MovieGetDetailProvider>()..getDetail(context, id: id),
        ),
        ChangeNotifierProvider(
          create: (_) =>
          sl<MovieGetVideosProvider>()..getVideos(context, id: id),
        ),
      ],
      builder: (_, __) => Scaffold(
        backgroundColor: Color(0xff060720),
        body: CustomScrollView(
          slivers: [
            _WidgetAppBar(context),
            Consumer<MovieGetVideosProvider>(
              builder: (_, provider, __) {
                final videos = provider.videos;
                if (videos != null) {
                  return SliverToBoxAdapter(
                    child: _Content(
                      title: 'Trailer',
                      body: SizedBox(
                        height: 160,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 1.0),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            final video = videos.results[index];
                            return Stack(
                              children: [
                                ImageNetworkComponent(
                                  radius: 12,
                                  type: TypePathImg.external,
                                  imagePath: YoutubePlayer.getThumbnail(
                                    videoId: video.key,
                                  ),
                                ),
                                Positioned.fill(
                                  child: Center(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(
                                          6.0,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                        size: 32.0,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => YoutubePlayerComponent(
                                              youtubeKey: video.key,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
                          itemCount: videos.results.length,
                        ),
                      ),
                    ),
                  );
                }
                return const SliverToBoxAdapter();
              },
            ),
            _WidgetSummary(),
          ],
        ),
      ),
    );
  }
}

class _WidgetAppBar extends SliverAppBar {
  final BuildContext context;

  const _WidgetAppBar(this.context);

  @override
  Color? get backgroundColor => Color(0xff060720);


  @override
  Color? get foregroundColor => Colors.black;

  @override
  Widget? get leading => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
        ),
      );

  @override
  List<Widget>? get actions => [
        Consumer<MovieGetDetailProvider>(
          builder: (_, provider, __) {
            final movie = provider.movie;

            if (movie != null) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  child: IconButton(
                    onPressed: () {
                      AppNavigator.customNavigator(
                          context: context,
                          screen: WebViewComponent(
                            title: movie.title,
                            url: movie.homepage,
                          ),
                          finish: false);
                    },
                    icon: const Icon(Icons.public),
                  ),
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ];

  @override
  double? get expandedHeight => 450;

  @override
  Widget? get flexibleSpace => Consumer<MovieGetDetailProvider>(
        builder: (_, provider, __) {
          final movie = provider.movie;

          if (movie != null) {
            return ItemMovie(
              movieDetail: movie,
              heightBackDrop: double.infinity,
              widthBackDrop: double.infinity,
              heightPoster: 160.0,
              widthPoster: 100.0,
            );
          }

          return Container(
            color: Colors.black12,
            height: double.infinity,
            width: double.infinity,
          );
        },
      );
}

class _Content extends StatelessWidget {
  const _Content({required this.title, required this.body});

  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
            left: 16.0,
            right: 16.0,
            bottom: 8.0,
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: body,
        ),
      ],
    );
  }
}

class _WidgetSummary extends SliverToBoxAdapter {
  TableRow _tableContent({required String title, required String content}) =>
      TableRow(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey.shade400),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(content,style: TextStyle(color: Colors.white),),
        ),
      ]);

  @override
  Widget? get child => Consumer<MovieGetDetailProvider>(
        builder: (_, provider, __) {
          final movie = provider.movie;

          if (movie != null) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Content(
                  title: 'Release Date',
                  body: Row(
                    children: [
                      Icon(
                        Icons.calendar_month_rounded,
                        size: 32.0,
                        color: Colors.grey.shade100

                      ),
                      const SizedBox(width: 6.0),
                      Text(
                        movie.releaseDate.toString().split(' ').first,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontStyle: FontStyle.italic,
                            color: Colors.grey.shade300
                        ),
                      ),
                    ],
                  ),
                ),
                _Content(
                  title: 'Genres',
                  body: Wrap(
                    spacing: 10,
                    children: movie.genres
                        .map((genre) => Chip(
                        backgroundColor: Color(0xff060720),
                        label: Text(genre.name,style: TextStyle(color: Colors.white),)))
                        .toList(),
                  ),
                ),
                _Content(title: 'Overview', body: Text(movie.overview,style: TextStyle(color: Colors.grey.shade500),)),
                _Content(
                  title: 'Summary',
                  body: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(2),
                    },
                    border: TableBorder.all(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    children: [
                      _tableContent(
                        title: "Adult",
                        content: movie.adult ? "Yes" : "No",
                      ),
                      _tableContent(
                        title: "Popularity",
                        content: '${movie.popularity}',
                      ),
                      _tableContent(
                        title: "Status",
                        content: movie.status,
                      ),
                      _tableContent(
                        title: "Budget",
                        content: "${movie.budget} 💰",
                      ),
                      _tableContent(
                        title: "Revenue",
                        content: "${movie.revenue} 💰",
                      ),
                      _tableContent(
                        title: "Tagline",
                        content: movie.tagline.isEmpty ? "No Tagline" : movie.tagline ,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return Container();
        },
      );
}
