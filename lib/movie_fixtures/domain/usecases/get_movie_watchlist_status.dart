import '../repositories/movie_repository.dart';

class GetMovieWatchlistStatus {
  final MovieRepository repository;

  GetMovieWatchlistStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
