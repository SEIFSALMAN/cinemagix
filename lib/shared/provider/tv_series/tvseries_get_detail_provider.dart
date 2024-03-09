import 'package:cinemagix/models/movie/movie_details_model.dart';
import 'package:cinemagix/models/tv_series/tvseries_details_model.dart';
import 'package:cinemagix/shared/repositories/tv_series/tvseries_repository.dart';
import 'package:flutter/material.dart';


class TVSeriesGetDetailProvider with ChangeNotifier {


  final TVSeriesRepository _tvSeriesRepository;
  TVSeriesGetDetailProvider(this._tvSeriesRepository);

  TvSeriesDetailModel? _seriesDetailModel;
  TvSeriesDetailModel? get seriesDetailModel => _seriesDetailModel;

  void getDetailTVSeries(BuildContext context, {required int id}) async {
    _seriesDetailModel = null;
    notifyListeners();
    final result = await _tvSeriesRepository.getDetailTVSeries(id: id);
    result.fold(
          (messageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(messageError)),
        );
        _seriesDetailModel = null;
        notifyListeners();
        return;
      },
          (response) {
        _seriesDetailModel = response;
        notifyListeners();
        return;
      },
    );
  }
}
