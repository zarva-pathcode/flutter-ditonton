part of 'tv_detail_bloc.dart';

abstract class TvDetailState extends Equatable {
  const TvDetailState();

  @override
  List<Object> get props => [];
}

class TvDetailData extends TvDetailState {
  final TvDetail tv;
  final bool isAddedToWatchlist;
  final List<Tv> tvRecommendations;
  final String errorMessage;
  final RequestState detailState;
  final RequestState recommendationState;
  final String watchlistMessage;

  const TvDetailData({
    required this.tv,
    required this.isAddedToWatchlist,
    required this.tvRecommendations,
    required this.errorMessage,
    required this.watchlistMessage,
    required this.detailState,
    required this.recommendationState,
  });

  TvDetailData copyWith({
    TvDetail? tv,
    List<Tv>? tvRecommendations,
    bool? isAddedToWatchlist,
    String? errorMessage,
    String? watchlistMessage,
    RequestState? detailState,
    RequestState? recommendationState,
  }) {
    return TvDetailData(
      tv: tv ?? this.tv,
      tvRecommendations: tvRecommendations ?? this.tvRecommendations,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      errorMessage: errorMessage ?? this.errorMessage,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      detailState: detailState ?? this.detailState,
      recommendationState: recommendationState ?? this.recommendationState,
    );
  }

  factory TvDetailData.empty() {
    return TvDetailData(
      tv: TvDetail(
        backdropPath: "",
        genres: [],
        id: 0,
        overview: "",
        posterPath: "",
        voteAverage: 0,
        voteCount: 0,
        firstAirDate: '',
        name: '',
        numberOfEps: 0,
        originalName: '',
      ),
      isAddedToWatchlist: false,
      tvRecommendations: [],
      errorMessage: "",
      watchlistMessage: "",
      detailState: RequestState.Empty,
      recommendationState: RequestState.Empty,
    );
  }

  @override
  List<Object> get props => [
        tv,
        isAddedToWatchlist,
        tvRecommendations,
        errorMessage,
        watchlistMessage,
        detailState,
        recommendationState,
      ];
}
