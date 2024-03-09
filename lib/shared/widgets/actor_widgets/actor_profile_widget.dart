import 'dart:developer';

import 'package:cinemagix/models/actor/actor_detail_model.dart';
import 'package:cinemagix/models/actor/actor_model.dart';
import 'package:flutter/material.dart';

import '../../../models/movie/movie_details_model.dart';
import '../../../models/movie/movie_model.dart';
import '../image_network_widget.dart';

class ActorProfileWidget extends Container {
  final ActorModel? actorModel;
  final ActorDetailModel? actorDetailModel;
  final double heightBackDrop;
  final double widthBackDrop;
  final double heightPoster;
  final double widthPoster;
  final void Function()? onTap;

  ActorProfileWidget(
      {this.actorModel,
        this.actorDetailModel,
        required this.widthBackDrop,
        required this.heightBackDrop,
        required this.widthPoster,
        required this.heightPoster,
        this.onTap
      });

  @override
  Widget get child {
    log(actorDetailModel.toString());
    return Stack(
    children: [
      ImageWidget(
          imagePath:
          '${actorDetailModel != null ? actorDetailModel!.profilePath : actorModel!.profilePath}',
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
                colors: [Colors.transparent, Colors.black])),
      ),
      Container(
        height: heightBackDrop,
        width: widthBackDrop,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.center,
                colors: [Colors.transparent, Colors.black54])),
      ),
      Positioned(
        left: 28,
        bottom: 18,
        right: 50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageWidget(
                imagePath:
                '${actorDetailModel != null ? actorDetailModel!.profilePath : actorModel!.profilePath}',
                width: widthPoster,
                height: heightPoster,
                radius: 10),
            SizedBox(
              height: 10,
            ),
            Text(
              actorDetailModel != null ? actorDetailModel!.name : actorModel!.name,
              style: TextStyle(
                  fontSize: 20,
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
                Text("Popularity : ${actorDetailModel!.popularity.toString()}",style: TextStyle(color: Colors.white),)
              ],
            ),
          ],
        ),
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 230.0),
          child: RotatedBox(
              quarterTurns: 1,
              child: Text(actorDetailModel!.name,style: TextStyle(fontSize: 50,color: Colors.grey.shade600),)
          ),
        ),
      ) ,
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
}
