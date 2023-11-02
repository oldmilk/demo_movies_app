import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/common/utils/base_use_case.dart';
import 'package:movie/common/utils/enums.dart';
import 'package:movie/modules/genres/domain/usecases/get_genres_usecase.dart';
import 'package:movie/modules/genres/presentation/controllers/genres_bloc/genres_event.dart';
import 'package:movie/modules/genres/presentation/controllers/genres_bloc/genres_state.dart';

class GenresBloc extends Bloc<GenresEvent, GenresState> {
  final GetGenresUseCase _getGenresUseCase;

  GenresBloc(
    this._getGenresUseCase,
  ) : super(const GenresState()) {
    on<GetGenresEvent>(_getGenres);
    on<ApplyGenresEvent>(_applyGenres);
  }

  Future<void> _getGenres(
      GetGenresEvent event, Emitter<GenresState> emit) async {
    emit(
      state.copyWith(
        status: RequestStatus.loading,
      ),
    );

    final result = await _getGenresUseCase(const NoParameters());
    result.fold(
      (l) => emit(
        state.copyWith(
          status: RequestStatus.error,
          message: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: RequestStatus.loaded,
          genres: r,
        ),
      ),
    );
  }

  Future<void> _applyGenres(
      ApplyGenresEvent event, Emitter<GenresState> emit) async {
    emit(
      state.copyWith(
        selectedGenres: event.genres,
      ),
    );
  }
}
