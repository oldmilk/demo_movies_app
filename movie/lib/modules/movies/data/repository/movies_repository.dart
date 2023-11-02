import 'package:dartz/dartz.dart';
import 'package:movie/app/entities/media.dart';
import 'package:movie/app/entities/media_details.dart';
import 'package:movie/common/error/failure.dart';
import 'package:movie/common/utils/base_use_case.dart';

abstract class MoviesRespository {
  Future<Either<Failure, MediaDetails>> getMovieDetails(int movieId);
  Future<Either<Failure, List<Media>>> getMovies(MovieFilter mf);
}
