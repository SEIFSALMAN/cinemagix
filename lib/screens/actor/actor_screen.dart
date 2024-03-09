import 'dart:developer';

import 'package:cinemagix/models/actor/actor_model.dart';
import 'package:cinemagix/screens/actor/actor_detail_screen.dart';
import 'package:cinemagix/screens/actor/actor_search_screen.dart';
import 'package:cinemagix/shared/app_constants.dart';
import 'package:cinemagix/shared/provider/actor/get_actors_provider.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../../shared/widgets/image_network_widget.dart';
import '../../shared/widgets/movies_widget/poster_and_backdrop_movie_widget.dart';
import '../../shared/widgets/navigator.dart';


class ActorScreen extends StatefulWidget {

  @override
  State<ActorScreen> createState() => _ActorScreenState();
}

class _ActorScreenState extends State<ActorScreen> {
  final PagingController<int, ActorModel> _pagingController =
  PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      context.read<GetActorsProvider>().getActorsWithPaging(context, page: pageKey, pagingController: _pagingController);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff060720),
      appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () => showSearch(
                context: context,
                delegate: ActorSearchScreen(),
              ),
              icon: const Icon(Icons.search,color: Colors.white),
            ),
          ],
        elevation: 0,
        backgroundColor: Color(0xff060720),
        foregroundColor: Colors.white,
        title: Text("Popular Actors")
      ),
      body: PagedListView.separated(
        padding: EdgeInsets.all(16),
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<ActorModel>(
          itemBuilder: (context, item, index) {
            // final knownFor = item.knownFor[index];
            log(index.toString());
            return Stack(
              children: [
                ImageWidget(
                    imagePath:
                    '${item.profilePath}',
                    width: 500,
                    height: 500,
                    radius: 10),
                Container(
                  height: 500,
                  width: 500,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black87])),
                ),
                Positioned(
                  left: 20,
                  bottom: 20,
                  right: 50,
                  child: Text(
                   item.name,
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: (){
                          AppNavigator.customNavigator(context: context, screen: ActorDetailScreen(id: item.id), finish: false);
                        }
                      ),
                    ),)
              ],
            );
          },
        ),
        separatorBuilder: (context, index) {
          return SizedBox(height: 15);
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

