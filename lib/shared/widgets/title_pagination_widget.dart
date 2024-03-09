
import 'package:flutter/material.dart';


class TitlePaginationWidget extends SliverToBoxAdapter {
  final String title;
  final void Function() onPressed;

  TitlePaginationWidget({required this.title, required this.onPressed});

  @override
  Widget get child => Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white)),
        OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 18)),
            child: Text("See All",style: TextStyle(color: Colors.white),))
      ],
    ),
  );
}
