import 'package:flutter/material.dart';

import '../app_constants.dart';

enum TypePathImg { movieDb, external }

class ImageNetworkComponent extends StatelessWidget {
  ImageNetworkComponent(
      {super.key,
      this.imagePath,
        this.type = TypePathImg.movieDb,
        this.width,
       this.height,
      required this.radius});

  final String? imagePath;
  final TypePathImg type;
  final double? height;
  final double? width;
  double radius = 0;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.network(
        type == TypePathImg.movieDb
            ? '${AppConstants.imageURLW500}$imagePath'
            : imagePath!,
        height: height,
        width: width,
        fit: BoxFit.cover,
        // loadingBuilder: (context, child, loadingProgress) {
        //   return Container(
        //     height: height,
        //     width: width,
        //     color: Colors.black26,
        //   );
        // },
        errorBuilder: (_, __, ___) => SizedBox(
          height: 300,
          width: double.maxFinite,
          child: Icon(Icons.broken_image_outlined),
        ),
      ),
    );
  }
}
