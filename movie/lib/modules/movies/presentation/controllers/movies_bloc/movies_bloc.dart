import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/common/utils/base_use_case.dart';
import 'package:movie/common/utils/enums.dart';
import 'package:movie/modules/movies/domain/usecases/get_movies_usecase.dart';
import 'package:movie/modules/movies/presentation/controllers/movies_bloc/movies_event.dart';
import 'package:movie/modules/movies/presentation/controllers/movies_bloc/movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetMoviesUseCase _getMoviesUseCase;

  MoviesBloc(
    this._getMoviesUseCase,
  ) : super(const MoviesState()) {
    on<RefreshMoviesEvent>(_refreshMovies);
    on<FetchMoreMoviesEvent>(_fetchMoreMovies);
    on<SortMoviesEvent>(_sortMovies);
    on<ApplyGenresMoviesEvent>(_getMoviesByGenres);
  }

  Future<void> _refreshMovies(
      RefreshMoviesEvent event, Emitter<MoviesState> emit) async {
    int currentPage = 1;

    emit(
      state.copyWith(
        status: GetAllRequestStatus.loading,
        page: currentPage,
      ),
    );

    final result = await _getMoviesUseCase(MovieFilter(
        page: currentPage, genres: state.genres, sortBy: state.sortBy));
    result.fold(
      (l) => emit(
        state.copyWith(
          status: GetAllRequestStatus.error,
          message: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: GetAllRequestStatus.loaded,
          movies: r,
        ),
      ),
    );
  }

  Future<void> _fetchMoreMovies(
      FetchMoreMoviesEvent event, Emitter<MoviesState> emit) async {
    int currentPage = state.page + 1;

    final result = await _getMoviesUseCase(MovieFilter(
        page: currentPage, genres: state.genres, sortBy: state.sortBy));
    result.fold(
      (l) => emit(
        state.copyWith(
          status: GetAllRequestStatus.fetchMoreError,
        ),
      ),
      (r) {
        return emit(
          state.copyWith(
            status: GetAllRequestStatus.loaded,
            movies: state.movies + r,
            page: currentPage,
          ),
        );
      },
    );
  }

  Future<void> _sortMovies(
      SortMoviesEvent event, Emitter<MoviesState> emit) async {
    int currentPage = 1;

    emit(
      state.copyWith(
          status: GetAllRequestStatus.loading,
          page: currentPage,
          sortBy: event.sortBy),
    );

    final result = await _getMoviesUseCase(MovieFilter(
        page: currentPage, genres: state.genres, sortBy: event.sortBy));
    result.fold(
      (l) => emit(
        state.copyWith(
          status: GetAllRequestStatus.error,
          message: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: GetAllRequestStatus.loaded,
          movies: r,
        ),
      ),
    );
  }

  Future<void> _getMoviesByGenres(
      ApplyGenresMoviesEvent event, Emitter<MoviesState> emit) async {
    int currentPage = 1;

    emit(
      state.copyWith(
          status: GetAllRequestStatus.loading,
          page: currentPage,
          genres: event.genres),
    );

    final result = await _getMoviesUseCase(MovieFilter(
        page: currentPage, genres: event.genres, sortBy: state.sortBy));
    result.fold(
      (l) => emit(
        state.copyWith(
          status: GetAllRequestStatus.error,
          message: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: GetAllRequestStatus.loaded,
          movies: r,
        ),
      ),
    );
  }
}
