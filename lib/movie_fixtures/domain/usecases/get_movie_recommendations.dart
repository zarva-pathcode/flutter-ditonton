import 'package:dartz/dartz.dart';
import 'package:ditonton/movie_fixtures/domain/repositories/movie_repository.dart';
import 'package:ditonton/core/common/failure.dart';

import '../entities/movie.dart';

class GetMovieRecommendations {
  final MovieRepository repository;

  GetMovieRecommendations(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getMovieRecommendations(id);
  }
}
