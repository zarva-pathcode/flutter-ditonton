import 'package:dartz/dartz.dart';
import 'package:ditonton/movie_fixtures/domain/repositories/movie_repository.dart';
import 'package:ditonton/core/common/failure.dart';

import '../entities/movie_detail.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
