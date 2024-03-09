import 'package:flutter/material.dart';

import '../../../models/movie/movie_details_model.dart';
import '../../../models/movie/movie_model.dart';
import '../image_network_widget.dart';

class PosterAndBackdropMovieWidget extends Container {
  final MovieModel? movie;
  final MovieDetailModel? movieDetail;
  final double heightBackDrop;
  final double widthBackDrop;
  final double heightPoster;
  final double widthPoster;
  final void Function()? onTap;

  PosterAndBackdropMovieWidget(
      {this.movie,
        this.movieDetail,
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
              '${movieDetail != null ? movieDetail!.backdropPath : movie!.backdropPath}',
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
                    '${movieDetail != null ? movieDetail!.posterPath : movie!.posterPath}',
                    width: widthPoster,
                    height: heightPoster,
                    radius: 10),
                SizedBox(
                  height: 10,
                ),
                Text(
                  movieDetail != null ? movieDetail!.title : movie!.title,
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
                      '${movieDetail != null ? movieDetail!.voteAverage.toString().substring(0,3) : movie!.voteAverage.toString().substring(0,3)} (${movieDetail != null ? movieDetail!.voteCount : movie!.voteCount})',
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
