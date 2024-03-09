import 'package:cinemagix/models/actor/actor_model.dart';
import 'package:cinemagix/shared/repositories/actor/actor_repository.dart';
import 'package:cinemagix/shared/repositories/movies/movie_repository.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../models/movie/movie_model.dart';


class GetActorsProvider with ChangeNotifier {
  final ActorRepository _actorRepository;

  GetActorsProvider(this._actorRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<ActorModel> _actors = [];
  List<ActorModel> get actors => _actors;

  void getActors(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final result = await _actorRepository.getActors();

    result.fold(
          (errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
        ));

        _isLoading = false;
        notifyListeners();
        return;
      },
          (response) {
        _actors.clear();
        _actors.addAll(response.results);
        _isLoading = false;
        notifyListeners();
        return null;
      },
    );
  }

  void getActorsWithPaging(BuildContext context,{required int page,required PagingController pagingController}) async {
    final result = await _actorRepository.getActors(page: page);

    result.fold(
          (errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
        ));

        pagingController.error = errorMessage;
        return;
      },
          (response) {

        if(response.results.length < 20) {
          pagingController.appendLastPage(response.results);
        }
        else {
          pagingController.appendPage(response.results, page + 1);
        }

        return null;
      },
    );
  }

}
