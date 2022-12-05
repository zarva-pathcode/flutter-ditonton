import 'package:equatable/equatable.dart';

import '../../domain/entities/tv.dart';

class TvModel extends Equatable {
  final int id;
  final String name;
  final String originalName;
  final String? posterPath;
  final String? overview;
  final String? backdropPath;

  TvModel({
    required this.id,
    required this.name,
    required this.originalName,
    required this.posterPath,
    required this.overview,
    required this.backdropPath,
  });

  factory TvModel.fromJson(Map<String, dynamic> json) => TvModel(
        id: json["id"],
        posterPath: json["poster_path"],
        overview: json["overview"],
        name: json["name"],
        backdropPath: json["backdrop_path"],
        originalName: json["original_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "overview": overview,
        "poster_path": posterPath,
        "name": name,
      };

  Tv toEntity() {
    return Tv(
      id: this.id,
      overview: this.overview,
      originalName: this.originalName,
      posterPath: this.posterPath,
      name: this.name,
      backdropPath: this.backdropPath,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        posterPath,
        backdropPath,
        originalName,
      ];
}
