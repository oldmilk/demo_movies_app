import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie/app/entities/media.dart';
import 'package:movie/app/entities/media_details.dart';
import 'package:movie/common/error/exceptions.dart';
import 'package:movie/common/error/failure.dart';
import 'package:movie/common/utils/base_use_case.dart';
import 'package:movie/modules/movies/data/datasource/movies_remote_data_source.dart';
import 'package:movie/modules/movies/data/repository/movies_repository.dart';

class MoviesRepositoryImpl extends MoviesRespository {
  final MoviesRemoteDataSource _baseMoviesRemoteDataSource;

  MoviesRepositoryImpl(this._baseMoviesRemoteDataSource);

  @override
  Future<Either<Failure, MediaDetails>> getMovieDetails(int movieId) async {
    try {
      final result = await _baseMoviesRemoteDataSource.getMovieDetails(movieId);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } on DioException catch (failure) {
      return Left(ServerFailure(failure.message));
    }
  }

  @override
  Future<Either<Failure, List<Media>>> getMovies(MovieFilter mf) async {
    try {
      final result = await _baseMoviesRemoteDataSource.getMoviesPath(mf);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } on DioException catch (failure) {
      return Left(ServerFailure(failure.message));
    }
  }
}
