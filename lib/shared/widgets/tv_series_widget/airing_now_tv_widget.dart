import 'package:cinemagix/shared/provider/tv_series/tvseries_get_now_playing_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../screens/tv_series/tvseries_detail_screen.dart';
import '../image_network_widget.dart';
import '../navigator.dart';


class AiringNowTVWidget extends StatefulWidget {
  const AiringNowTVWidget({super.key});

  @override
  State<AiringNowTVWidget> createState() => _AiringNowTVWidgetState();
}

class _AiringNowTVWidgetState extends State<AiringNowTVWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TVSeriesGetAiringNowProvider>().getAiringNow(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
        child: Consumer<TVSeriesGetAiringNowProvider>(
          builder: (_, provider, __) {
            if (provider.isLoading) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(12.0)),
              );
            }

            if (provider.series.isNotEmpty) {
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  final movie = provider.series[index];

                  return Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        width: MediaQuery.of(context).size.width * 0.89,
                        height: 205,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade800),

                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black12,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageWidget(
                              imagePath: movie.posterPath,
                              height: 200,
                              width: 120,
                              radius: 12.0,
                            ),
                            const SizedBox(width: 8.0),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    movie.name,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star_rounded,
                                        color: Colors.amber,
                                        size: 16,
                                      ),
                                      Text(
                                        '${movie.voteAverage} (${movie.voteCount})',
                                        style: const TextStyle(
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Story movie : ${movie.overview}",
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey.shade400

                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned.fill(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              AppNavigator.customNavigator(
                                  context: context,
                                  screen: TVSeriesDetailScreen(id: movie.id),
                                  finish: false);
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(
                  width: 8.0,
                ),
                itemCount: provider.series.length,
              );
            }

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Center(
                child: Text('Not found now playing series'),
              ),
            );
          },
        ),
      ),
    );
  }
}
