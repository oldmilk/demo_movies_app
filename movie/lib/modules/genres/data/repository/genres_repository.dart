import 'package:dartz/dartz.dart';
import 'package:movie/app/entities/genre.dart';
import 'package:movie/common/error/failure.dart';

abstract class GenresRespository {
  Future<Either<Failure, List<Genre>>> getGenres();
}
