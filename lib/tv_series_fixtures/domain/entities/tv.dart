import 'package:equatable/equatable.dart';

class Tv extends Equatable {
  Tv({
    required this.backdropPath,
    required this.id,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

  Tv.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

  String? backdropPath;
  int id;
  String? originalName;
  String? overview;
  String? posterPath;
  String? name;

  @override
  List<Object?> get props => [
        backdropPath,
        id,
        originalName,
        overview,
        posterPath,
        name,
      ];
}
