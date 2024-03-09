import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinemagix/shared/provider/tv_series/tvseries_get_discover_provider.dart';
import 'package:cinemagix/shared/widgets/navigator.dart';
import 'package:cinemagix/shared/widgets/tv_series_widget/poster_and_backdrop_tv_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../screens/tv_series/tvseries_detail_screen.dart';

class DiscoverTVSeriesWidget extends StatefulWidget {
  const DiscoverTVSeriesWidget({super.key});

  @override
  State<DiscoverTVSeriesWidget> createState() => _DiscoverTVSeriesWidgetState();
}

class _DiscoverTVSeriesWidgetState extends State<DiscoverTVSeriesWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TVSeriesGetDiscoverProvider>().getDiscoverTVSeries(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<TVSeriesGetDiscoverProvider>(
        builder: (_, provider, __) {
          if (provider.isLoading) {
            return Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                height: 300,
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

          if (provider.series.isNotEmpty) {
            return CarouselSlider.builder(
                itemCount: provider.series.length,
                itemBuilder: (_, index, __) {
                  final series = provider.series[index];
                  return PosterAndBackdropTVWidget(
                    seriesModel: series,
                    heightBackDrop: 300,
                    widthBackDrop: double.maxFinite,
                    heightPoster: 180,
                    widthPoster: 100,
                    onTap: ()=> AppNavigator.customNavigator(context: context, screen: TVSeriesDetailScreen(id: series.id), finish: false),
                  );
                },
                options: CarouselOptions(
                    viewportFraction: 0.8,
                    height: 300,
                    reverse: false,
                    autoPlay: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal));
          }
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            height: 300,
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.black12, borderRadius: BorderRadius.circular(12)),
            child: Center(
                child: Text(
                  "Not found Discover series",
                  style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                )),
          );
        },
      ),
    );
  }
}
