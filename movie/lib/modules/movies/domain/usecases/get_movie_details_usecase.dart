import 'package:dartz/dartz.dart';

import 'package:movie/app/entities/media_details.dart';
import 'package:movie/common/error/failure.dart';
import 'package:movie/common/utils/base_use_case.dart';
import 'package:movie/modules/movies/data/repository/movies_repository.dart';

class GetMoviesDetailsUseCase extends BaseUseCase<MediaDetails, int> {
  final MoviesRespository _baseMoviesRespository;

  GetMoviesDetailsUseCase(this._baseMoviesRespository);

  @override
  Future<Either<Failure, MediaDetails>> call(int p) async {
    return await _baseMoviesRespository.getMovieDetails(p);
  }
}
