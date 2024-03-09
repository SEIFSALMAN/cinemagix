import 'package:cinemagix/models/actor/actor_detail_model.dart';
import 'package:cinemagix/models/actor/actor_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'actor_repository.dart';

class ActorRepositoryImplementation implements ActorRepository {


  final Dio _dio;
  ActorRepositoryImplementation(this._dio);

  @override
  Future<Either<String, ActorResponseModel>> getActors({int page = 1}) async {
    try {
      final result = await _dio.get(
        '/person/popular',
        queryParameters: {'page': page},
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = ActorResponseModel.fromJson(result.data);
        return Right(model);
      }

      return const Left('Error get actors');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return const Left('Another error on get actors');
    }
  }

  @override
  Future<Either<String, ActorDetailModel>> getDetailActors({required int id}) async {
    try {
      final result = await _dio.get(
        '/person/$id',
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = ActorDetailModel.fromJson(result.data);
        return Right(model);
      }

      return const Left('Error get details about the actor');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return const Left('Another error on get details about the actor');
    }
  }

  @override
  Future<Either<String, ActorResponseModel>> searchOnActor({required String query}) async {
    try {
      final result = await _dio.get(
          '/search/person',
          queryParameters: {'query' : query}
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = ActorResponseModel.fromJson(result.data);
        return Right(model);
      }

      return const Left('Error while search the actor');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return const Left('Another error on searching the actor');
    }
  }


}