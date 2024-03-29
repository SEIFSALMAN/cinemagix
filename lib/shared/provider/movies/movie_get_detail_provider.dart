import 'package:cinemagix/models/movie/movie_details_model.dart';
import 'package:cinemagix/shared/repositories/movies/movie_repository.dart';
import 'package:flutter/material.dart';
class MovieGetDetailProvider with ChangeNotifier {

  final MovieRepository _movieRepository;
  MovieGetDetailProvider(this._movieRepository);

  MovieDetailModel? _movie;
  MovieDetailModel? get movie => _movie;

  void getDetailMovie(BuildContext context, {required int id}) async {
    _movie = null;
    notifyListeners();
    final result = await _movieRepository.getDetailMovies(id: id);
    result.fold(
          (messageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(messageError)),
        );
        _movie = null;
        notifyListeners();
        return;
      },
          (response) {
        _movie = response;
        notifyListeners();
        return;
      },
    );
  }
}
