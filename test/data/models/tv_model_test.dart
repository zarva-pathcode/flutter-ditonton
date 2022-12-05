import 'package:ditonton/tv_series_fixtures/data/models/tv_model.dart';
import 'package:ditonton/tv_series_fixtures/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvModel = TvModel(
    backdropPath: 'backdropPath',
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    posterPath: 'posterPath',
    name: 'name',
  );

  final tTv = Tv(
    backdropPath: 'backdropPath',
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    posterPath: 'posterPath',
    name: 'name',
  );

  test('should be a subclass of Movie entity', () async {
    final result = tTvModel.toEntity();
    expect(result, tTv);
  });
}
