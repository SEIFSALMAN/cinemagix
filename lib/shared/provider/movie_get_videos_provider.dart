import 'package:cinemagix/models/movie/movie_details_model.dart';
import 'package:cinemagix/models/movie/movie_video_model.dart';
import 'package:cinemagix/models/repostories/movie_repository.dart';
import 'package:flutter/material.dart';
class MovieGetVideosProvider with ChangeNotifier {

  final MovieRepository _videosRepository;
  MovieGetVideosProvider(this._videosRepository);

  MovieVideosModel? _videos;
  MovieVideosModel? get videos => _videos;

  void getVideos(BuildContext context, {required int id}) async {
    _videos = null;
    notifyListeners();
    final result = await _videosRepository.getVideos(id: id);
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
