import 'package:cinemagix/models/actor/actor_detail_model.dart';
import 'package:cinemagix/models/actor/actor_detail_model.dart';
import 'package:cinemagix/models/movie/movie_details_model.dart';
import 'package:cinemagix/shared/repositories/actor/actor_repository.dart';
import 'package:cinemagix/shared/repositories/movies/movie_repository.dart';
import 'package:flutter/material.dart';

class ActorGetDetailProvider with ChangeNotifier {
  final ActorRepository _actorRepository;

  ActorGetDetailProvider(this._actorRepository);

  ActorDetailModel? _actor;
  ActorDetailModel? get actor => _actor;

  void getDetailActor(BuildContext context, {required int id}) async {
    _actor = null;
    notifyListeners();
    final result = await _actorRepository.getDetailActors(id: id);
    result.fold(
      (messageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(messageError)),
        );
        _actor = null;
        notifyListeners();
        return;
      },
      (response) {
        _actor = response;
        notifyListeners();
        return;
      },
    );
  }
}
