import 'package:ditonton/core/common/network_info.dart';
import 'package:ditonton/core/data/db/database_helper.dart';
import 'package:ditonton/movie_fixtures/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/movie_fixtures/data/datasources/movie_remote_data_source.dart';

import 'package:ditonton/movie_fixtures/domain/repositories/movie_repository.dart';
import 'package:ditonton/tv_series_fixtures/data/datasources/tv_local_data_source.dart';
import 'package:ditonton/tv_series_fixtures/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/tv_series_fixtures/domain/repositories/tv_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  TvRepository,
  TvRemoteDataSource,
  TvLocalDataSource,
  NetworkInfo,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
