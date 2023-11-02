import 'package:equatable/equatable.dart';
import 'package:movie/app/entities/genre.dart';

abstract class GenresEvent extends Equatable {
  const GenresEvent();

  @override
  List<Object?> get props => [];
}

class GetGenresEvent extends GenresEvent {
  const GetGenresEvent();
}

class ApplyGenresEvent extends GenresEvent {
  final List<Genre> genres;

  const ApplyGenresEvent({required this.genres});

  @override
  List<Object?> get props => [genres];
}
