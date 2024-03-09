import 'package:cinemagix/shared/provider/tv_series/tvseries_get_top_rated_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../screens/tv_series/tvseries_detail_screen.dart';
import '../image_network_widget.dart';
import '../navigator.dart';

class TopRatedTVWidget extends StatefulWidget {
  const TopRatedTVWidget({super.key});

  @override
  State<TopRatedTVWidget> createState() => _TopRatedTVWidgetState();
}

class _TopRatedTVWidgetState extends State<TopRatedTVWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TVSeriesGetTopRatedProvider>().getTopRated(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 270,
        child: Consumer<TVSeriesGetTopRatedProvider>(
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

            if (provider.series.isNotEmpty) {
              return ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.series.length,
                  separatorBuilder: (_, __) => SizedBox(width: 15),
                  itemBuilder: (_, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: ()=> AppNavigator.customNavigator(context: context, screen: TVSeriesDetailScreen(id: provider.series[index].id), finish: false),
                          child: ImageWidget(
                              imagePath: provider.series[index].posterPath,
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
                            child: Text(provider.series[index].name,style: TextStyle(color: Colors.white,fontSize: 12),textAlign: TextAlign.center,maxLines: 2,)
                        )
                        // Text(provider.series[index].title)
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
                "Not found top rated series",
                style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
              )),
            );
          },
        ),
      ),
    );
  }
}
