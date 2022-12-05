import 'dart:convert';

import 'package:ditonton/tv_series_fixtures/data/models/tv_model.dart';
import 'package:ditonton/tv_series_fixtures/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvModel = TvModel(
    backdropPath: "/path",
    id: 210855,
    originalName: "Now What",
    overview: "Overview",
    posterPath: "/path",
    name: "Now what",
  );
  final tTvResponseModel = TvResponse(tvList: <TvModel>[tTvModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/now_playing_tvs.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "poster_path": "/path",
            "id": 210855,
            "name": "Now what",
            "overview": "Overview",
          }
        ]
      };
      expect(result, expectedJsonMap);
    });
  });
}
