import 'package:cinemagix/models/tv_series/tvseries_model.dart';
import 'package:cinemagix/models/tv_series/tvseries_model.dart';
import 'package:cinemagix/shared/repositories/movies/movie_repository.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../models/movie/movie_model.dart';
import '../../repositories/tv_series/tvseries_repository.dart';

class TVSeriesGetTopRatedProvider with ChangeNotifier {
  final TVSeriesRepository _seriesRepository;

  TVSeriesGetTopRatedProvider(this._seriesRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<TVSeriesModel> _series = [];
  List<TVSeriesModel> get series => _series;

  void getTopRated(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final result = await _seriesRepository.getTopRatedTVSeries();

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
        return null;
      },
    );
  }

  void getTopRatedTVWithPaging(BuildContext context,{required int page,required PagingController pagingController}) async {
    final result = await _seriesRepository.getTopRatedTVSeries(page: page);

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
