import 'package:dartz/dartz.dart';
import 'package:ditonton/core/common/failure.dart';

import '../entities/tv.dart';
import '../repositories/tv_repository.dart';

class GetTvRecommendations {
  final TvRepository repository;

  GetTvRecommendations(this.repository);

  Future<Either<Failure, List<Tv>>> execute(id) {
    return repository.getTvRecommendations(id);
  }
}
