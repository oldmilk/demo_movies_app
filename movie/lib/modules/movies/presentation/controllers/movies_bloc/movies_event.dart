import 'package:equatable/equatable.dart';
import 'package:movie/app/constants/api_enums.dart';
import 'package:movie/app/entities/genre.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();
  @override
  List<Object?> get props => [];
}

class SortMoviesEvent extends MoviesEvent {
  final SortBy sortBy;

  const SortMoviesEvent({required this.sortBy});

  @override
  List<Object?> get props => [sortBy];
}

class ApplyGenresMoviesEvent extends MoviesEvent {
  final List<Genre> genres;

  const ApplyGenresMoviesEvent({required this.genres});

  @override
  List<Object?> get props => [genres];
}

class RefreshMoviesEvent extends MoviesEvent {
  const RefreshMoviesEvent();
}

class FetchMoreMoviesEvent extends MoviesEvent {
  const FetchMoreMoviesEvent();
}
