import 'package:cinemagix/models/tv_series/tvseries_details_model.dart';
import 'package:cinemagix/models/tv_series/tvseries_model.dart';
import 'package:flutter/material.dart';

import '../image_network_widget.dart';

class PosterAndBackdropTVWidget extends Container {
  final TVSeriesModel? seriesModel;
  final TvSeriesDetailModel? seriesDetailModel;
  final double heightBackDrop;
  final double widthBackDrop;
  final double heightPoster;
  final double widthPoster;
  final void Function()? onTap;

  PosterAndBackdropTVWidget(
      {this.seriesModel,
        this.seriesDetailModel,
      required this.widthBackDrop,
      required this.heightBackDrop,
      required this.widthPoster,
      required this.heightPoster,
        this.onTap
      });

  @override
  Widget get child => Stack(
        children: [
          ImageWidget(
              imagePath:
              '${seriesDetailModel != null ? seriesDetailModel!.backdropPath : seriesModel!.backdropPath}',
              width: widthBackDrop,
              height: heightBackDrop,
              radius: 10),
          Container(
            height: heightBackDrop,
            width: widthBackDrop,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black87])),
          ),
          Positioned(
            left: 18,
            bottom: 18,
            right: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageWidget(
                    imagePath:
                    '${seriesDetailModel != null ? seriesDetailModel!.posterPath : seriesModel!.posterPath}',
                    width: widthPoster,
                    height: heightPoster,
                    radius: 10),
                SizedBox(
                  height: 10,
                ),
                Text(
                  seriesDetailModel != null ? seriesDetailModel!.name : seriesModel!.name,
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(Icons.star_purple500_outlined,
                        color: Colors.amberAccent),
                    SizedBox(width: 5),
                    Text(
                      '${seriesDetailModel != null ? seriesDetailModel!.voteAverage.toString().substring(0,3) : seriesModel!.voteAverage.toString().substring(0,3)} (${seriesDetailModel != null ? seriesDetailModel!.voteCount : seriesModel!.voteCount})',
                      style: TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned.fill(
              child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
            ),
          ))
        ],
      );
}
