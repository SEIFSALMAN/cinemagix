import 'package:cinemagix/models/movie/movie_details_model.dart';
import 'package:cinemagix/models/movie/movie_trailer_videos_model.dart';
import 'package:cinemagix/models/tv_series/tvseries_trailer_videos_model.dart';
import 'package:cinemagix/shared/repositories/movies/movie_repository.dart';
import 'package:cinemagix/shared/repositories/tv_series/tvseries_repository.dart';
import 'package:flutter/material.dart';
class TVSeriesGetVideosProvider with ChangeNotifier {

  final TVSeriesRepository _videosRepository;
  TVSeriesGetVideosProvider(this._videosRepository);

  TvSeriesTrailerVideosModel? _videos;
  TvSeriesTrailerVideosModel? get videos => _videos;

  void getVideos(BuildContext context, {required int id}) async {
    _videos = null;
    notifyListeners();
    final result = await _videosRepository.getTVSeriesTrailerVideos(id: id);
    result.fold(
          (messageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(messageError)),
        );
        _videos = null;
        notifyListeners();
        return;
      },
          (response) {
        _videos = response;
        notifyListeners();
        return;
      },
    );
  }
}
