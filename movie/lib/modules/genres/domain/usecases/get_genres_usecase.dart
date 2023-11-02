import 'package:dartz/dartz.dart';
import 'package:movie/app/entities/genre.dart';

import 'package:movie/common/error/failure.dart';
import 'package:movie/common/utils/base_use_case.dart';
import 'package:movie/modules/genres/data/repository/genres_repository.dart';

class GetGenresUseCase extends BaseUseCase<List<Genre>, NoParameters> {
  final GenresRespository _baseGenresRespository;

  GetGenresUseCase(this._baseGenresRespository);

  @override
  Future<Either<Failure, List<Genre>>> call(NoParameters p) async {
    return await _baseGenresRespository.getGenres();
  }
}
