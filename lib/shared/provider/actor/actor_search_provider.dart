import 'package:cinemagix/models/actor/actor_model.dart';
import 'package:cinemagix/shared/repositories/actor/actor_repository.dart';
import 'package:flutter/material.dart';

import '../../../models/movie/movie_model.dart';


class ActorSearchProvider with ChangeNotifier {
  final ActorRepository _actorRepository;

  ActorSearchProvider(this._actorRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<ActorModel> _actor = [];
  List<ActorModel> get actor => _actor;

  void searchOnActor(BuildContext context , {required String query}) async {
    _isLoading = true;
    notifyListeners();

    final result = await _actorRepository.searchOnActor(query: query);

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
        _actor.clear();
        _actor.addAll(response.results);
        _isLoading = false;
        notifyListeners();
        return;
      },
    );
  }


}
