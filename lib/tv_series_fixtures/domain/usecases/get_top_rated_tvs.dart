import 'package:dartz/dartz.dart';

import '../../../core/common/failure.dart';
import '../entities/tv.dart';
import '../repositories/tv_repository.dart';

class GetTopRatedTvs {
  final TvRepository repository;

  GetTopRatedTvs(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getTopRatedTvs();
  }
}
