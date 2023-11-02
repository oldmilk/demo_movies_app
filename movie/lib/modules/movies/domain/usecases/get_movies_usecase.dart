import 'package:dartz/dartz.dart';
import 'package:movie/app/entities/media.dart';
import 'package:movie/common/error/failure.dart';
import 'package:movie/common/utils/base_use_case.dart';
import 'package:movie/modules/movies/data/repository/movies_repository.dart';

class GetMoviesUseCase extends BaseUseCase<List<Media>, MovieFilter> {
  final MoviesRespository _baseMoviesRespository;

  GetMoviesUseCase(this._baseMoviesRespository);

  @override
  Future<Either<Failure, List<Media>>> call(MovieFilter p) async {
    return await _baseMoviesRespository.getMovies(p);
  }
}
