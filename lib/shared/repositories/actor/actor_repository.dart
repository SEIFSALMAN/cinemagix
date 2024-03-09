
import 'package:cinemagix/models/actor/actor_detail_model.dart';
import 'package:cinemagix/models/actor/actor_model.dart';
import 'package:dartz/dartz.dart';

abstract class ActorRepository {
  Future<Either<String,ActorResponseModel>> getActors({int page = 1});
  Future<Either<String,ActorDetailModel>> getDetailActors({required int id});
  Future<Either<String,ActorResponseModel>> searchOnActor({required String query});

}