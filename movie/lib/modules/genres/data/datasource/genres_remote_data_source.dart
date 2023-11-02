import 'package:dio/dio.dart';
import 'package:movie/app/constants/api_constants.dart';
import 'package:movie/common/error/exceptions.dart';
import 'package:movie/common/network/error_message_model.dart';
import 'package:movie/modules/genres/data/models/genre_model.dart';

abstract class GenresRemoteDataSource {
  Future<List<GenreModel>> getGenres();
}

class GenresRemoteDataSourceImpl extends GenresRemoteDataSource {
  @override
  Future<List<GenreModel>> getGenres() async {
    final response = await Dio().get(ApiConstants.getGenresPath());
    if (response.statusCode == 200) {
      return List<GenreModel>.from(
          (response.data['genres'] as List).map((e) => GenreModel.fromJson(e)));
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
