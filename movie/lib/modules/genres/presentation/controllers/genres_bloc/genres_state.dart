import 'package:equatable/equatable.dart';
import 'package:movie/app/entities/genre.dart';

import 'package:movie/common/utils/enums.dart';

class GenresState extends Equatable {
  final List<Genre> genres;
  final List<Genre> selectedGenres;
  final RequestStatus status;
  final String message;

  const GenresState({
    this.genres = const [],
    this.selectedGenres = const [],
    this.status = RequestStatus.loading,
    this.message = '',
  });

  GenresState copyWith({
    List<Genre>? genres,
    List<Genre>? selectedGenres,
    RequestStatus? status,
    String? message,
  }) {
    return GenresState(
      genres: genres ?? this.genres,
      selectedGenres: selectedGenres ?? this.selectedGenres,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        genres,
        selectedGenres,
        status,
        message,
      ];
}
