import 'package:cinemagix/models/tv_series/tvseries_model.dart';
import 'package:cinemagix/shared/repositories/movies/movie_repository.dart';
import 'package:cinemagix/shared/repositories/tv_series/tvseries_repository.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../models/movie/movie_model.dart';


class TVSeriesSearchProvider with ChangeNotifier {
  final TVSeriesRepository _seriesRepository;

  TVSeriesSearchProvider(this._seriesRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<TVSeriesModel> _series = [];
  List<TVSeriesModel> get series => _series;

  void search(BuildContext context , {required String query}) async {
    _isLoading = true;
    notifyListeners();

    final result = await _seriesRepository.searchOnTVSeries(query: query);

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
        _series.clear();
        _series.addAll(response.results);
        _isLoading = false;
        notifyListeners();
        return;
      },
    );
  }


}
