import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie/app/entities/genre.dart';

import 'package:movie/common/error/exceptions.dart';
import 'package:movie/common/error/failure.dart';
import 'package:movie/modules/genres/data/datasource/genres_remote_data_source.dart';
import 'package:movie/modules/genres/data/repository/genres_repository.dart';

class GenresRepositoryImpl extends GenresRespository {
  final GenresRemoteDataSource _baseGenresRemoteDataSource;

  GenresRepositoryImpl(this._baseGenresRemoteDataSource);

  @override
  Future<Either<Failure, List<Genre>>> getGenres() async {
    try {
      final result = await _baseGenresRemoteDataSource.getGenres();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } on DioException catch (failure) {
      return Left(ServerFailure(failure.message));
    }
  }
}
