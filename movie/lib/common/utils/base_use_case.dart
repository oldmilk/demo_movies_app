import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/app/constants/api_enums.dart';
import 'package:movie/app/entities/genre.dart';
import 'package:movie/common/error/failure.dart';

abstract class BaseUseCase<T, P> {
  Future<Either<Failure, T>> call(P p);
}

class NoParameters extends Equatable {
  const NoParameters();
  @override
  List<Object?> get props => [];
}

class MovieFilter extends Equatable {
  final int page;
  final List<Genre> genres;
  final SortBy sortBy;

  const MovieFilter({
    required this.page,
    required this.genres,
    required this.sortBy,
  });

  @override
  List<Object?> get props => [
        page,
        genres,
        sortBy,
      ];
}
