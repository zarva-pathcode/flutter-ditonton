part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailData extends MovieDetailState {
  final MovieDetail movie;
  final bool isAddedToWatchlist;
  final List<Movie> movieRecommendations;
  final String errorMessage;
  final RequestState detailState;
  final RequestState recommendationState;
  final String watchlistMessage;

  const MovieDetailData({
    required this.movie,
    required this.isAddedToWatchlist,
    required this.movieRecommendations,
    required this.errorMessage,
    required this.watchlistMessage,
    required this.detailState,
    required this.recommendationState,
  });

  MovieDetailData copyWith({
    MovieDetail? movie,
    List<Movie>? movieRecommendations,
    bool? isAddedToWatchlist,
    String? errorMessage,
    String? watchlistMessage,
    RequestState? detailState,
    RequestState? recommendationState,
  }) {
    return MovieDetailData(
      movie: movie ?? this.movie,
      movieRecommendations: movieRecommendations ?? this.movieRecommendations,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      errorMessage: errorMessage ?? this.errorMessage,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      detailState: detailState ?? this.detailState,
      recommendationState: recommendationState ?? this.recommendationState,
    );
  }

  factory MovieDetailData.empty() {
    return MovieDetailData(
      movie: MovieDetail(
        adult: false,
        backdropPath: "",
        genres: [],
        id: 0,
        originalTitle: "",
        overview: "",
        posterPath: "",
        releaseDate: "",
        runtime: 0,
        title: "",
        voteAverage: 0,
        voteCount: 0,
      ),
      isAddedToWatchlist: false,
      movieRecommendations: [],
      errorMessage: "",
      watchlistMessage: "",
      detailState: RequestState.Empty,
      recommendationState: RequestState.Empty,
    );
  }

  @override
  List<Object> get props => [
        movie,
        isAddedToWatchlist,
        movieRecommendations,
        errorMessage,
        watchlistMessage,
        detailState,
        recommendationState,
      ];
}
