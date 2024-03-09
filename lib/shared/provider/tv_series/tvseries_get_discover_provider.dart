import 'package:cinemagix/models/tv_series/tvseries_model.dart';
import 'package:cinemagix/shared/repositories/movies/movie_repository.dart';
import 'package:cinemagix/shared/repositories/tv_series/tvseries_repository.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../models/movie/movie_model.dart';


class TVSeriesGetDiscoverProvider with ChangeNotifier {
  final TVSeriesRepository _tvSeriesRepository;

  TVSeriesGetDiscoverProvider(this._tvSeriesRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<TVSeriesModel> _series = [];
  List<TVSeriesModel> get series => _series;

  void getDiscoverTVSeries(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final result = await _tvSeriesRepository.getDiscoverTVSeries();

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

  void getDiscoverTVWithPaging(BuildContext context,{required int page,required PagingController pagingController}) async {
    final result = await _tvSeriesRepository.getDiscoverTVSeries(page: page);

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
