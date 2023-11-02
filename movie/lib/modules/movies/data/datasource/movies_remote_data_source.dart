import 'package:dio/dio.dart';
import 'package:movie/app/constants/api_constants.dart';
import 'package:movie/common/error/exceptions.dart';
import 'package:movie/common/network/error_message_model.dart';
import 'package:movie/common/utils/base_use_case.dart';

import 'package:movie/modules/movies/data/models/movie_details_model.dart';
import 'package:movie/modules/movies/data/models/movie_model.dart';

abstract class MoviesRemoteDataSource {
  Future<List<MovieModel>> getMoviesPath(MovieFilter mf);
  Future<MovieDetailsModel> getMovieDetails(int movieId);
}

class MoviesRemoteDataSourceImpl extends MoviesRemoteDataSource {
  @override
  Future<List<MovieModel>> getMoviesPath(MovieFilter mf) async {
    final response = await Dio().get(ApiConstants.getMoviesPath(
        page: mf.page, genres: mf.genres, sortBy: mf.sortBy));
    if (response.statusCode == 200) {
      return List<MovieModel>.from((response.data['results'] as List)
          .map((e) => MovieModel.fromJson(e)));
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<MovieDetailsModel> getMovieDetails(int movieId) async {
    final response = await Dio().get(ApiConstants.getMovieDetailsPath(movieId));
    if (response.statusCode == 200) {
      return MovieDetailsModel.fromJson(response.data);
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
