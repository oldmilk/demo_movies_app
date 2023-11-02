import 'package:equatable/equatable.dart';
import 'package:movie/app/constants/api_enums.dart';
import 'package:movie/app/entities/genre.dart';
import 'package:movie/app/entities/media.dart';
import 'package:movie/common/utils/enums.dart';

class MoviesState extends Equatable {
  final List<Media> movies;
  final GetAllRequestStatus status;
  final String message;
  final SortBy sortBy;
  final int page;
  final List<Genre> genres;

  const MoviesState({
    this.movies = const [],
    this.status = GetAllRequestStatus.loading,
    this.message = '',
    this.sortBy = SortBy.primaryReleaseDateDesc,
    this.page = 1,
    this.genres = const [],
  });

  MoviesState copyWith({
    List<Media>? movies,
    GetAllRequestStatus? status,
    String? message,
    SortBy? sortBy,
    int? page,
    List<Genre>? genres,
  }) {
    return MoviesState(
      movies: movies ?? this.movies,
      status: status ?? this.status,
      message: message ?? this.message,
      sortBy: sortBy ?? this.sortBy,
      page: page ?? this.page,
      genres: genres ?? this.genres,
    );
  }

  @override
  List<Object?> get props => [movies, status, message, sortBy, page, genres];
}
