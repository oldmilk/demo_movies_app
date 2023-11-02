import 'package:get_it/get_it.dart';
import 'package:movie/modules/genres/data/datasource/genres_remote_data_source.dart';
import 'package:movie/modules/genres/data/repository/genres_repository.dart';
import 'package:movie/modules/genres/data/repository/genres_repository_impl.dart';
import 'package:movie/modules/genres/domain/usecases/get_genres_usecase.dart';
import 'package:movie/modules/genres/presentation/controllers/genres_bloc/genres_bloc.dart';
import 'package:movie/modules/movies/data/datasource/movies_remote_data_source.dart';
import 'package:movie/modules/movies/data/repository/movies_repository_impl.dart';
import 'package:movie/modules/movies/data/repository/movies_repository.dart';
import 'package:movie/modules/movies/domain/usecases/get_movie_details_usecase.dart';
import 'package:movie/modules/movies/domain/usecases/get_movies_usecase.dart';
import 'package:movie/modules/movies/presentation/controllers/movie_details_bloc/movie_details_bloc.dart';
import 'package:movie/modules/movies/presentation/controllers/movies_bloc/movies_bloc.dart';
import 'package:movie/modules/search/data/datasource/recent_local_data_source.dart';
import 'package:movie/modules/search/data/datasource/search_remote_data_source.dart';
import 'package:movie/modules/search/data/repository/recent_repository.dart';
import 'package:movie/modules/search/data/repository/recent_repository_impl.dart';
import 'package:movie/modules/search/data/repository/search_repository_impl.dart';
import 'package:movie/modules/search/data/repository/search_repository.dart';
import 'package:movie/modules/search/domain/usecases/add_recent_item_usecase.dart';
import 'package:movie/modules/search/domain/usecases/get_recent_items_usecase.dart';
import 'package:movie/modules/search/domain/usecases/remove_recent_item_usecase.dart';
import 'package:movie/modules/search/domain/usecases/search_usecase.dart';
import 'package:movie/modules/search/presentation/controllers/recent_bloc/recent_bloc.dart';
import 'package:movie/modules/search/presentation/controllers/search_bloc/search_bloc.dart';

final sl = GetIt.instance;

class ServiceLocator {
  static void init() {
    // Data source
    sl.registerLazySingleton<MoviesRemoteDataSource>(
        () => MoviesRemoteDataSourceImpl());
    sl.registerLazySingleton<GenresRemoteDataSource>(
        () => GenresRemoteDataSourceImpl());
    sl.registerLazySingleton<SearchRemoteDataSource>(
        () => SearchRemoteDataSourceImpl());
    sl.registerLazySingleton<RecentLocalDataSource>(
        () => RecentLocalDataSourceImpl());

    // Repository
    sl.registerLazySingleton<MoviesRespository>(
        () => MoviesRepositoryImpl(sl()));
    sl.registerLazySingleton<GenresRespository>(
        () => GenresRepositoryImpl(sl()));
    sl.registerLazySingleton<SearchRepository>(
        () => SearchRepositoryImpl(sl()));
    sl.registerLazySingleton<RecentRepository>(
        () => RecentRepositoryImpl(sl()));

    // Use Cases
    sl.registerLazySingleton(() => GetGenresUseCase(sl()));
    sl.registerLazySingleton(() => GetMoviesDetailsUseCase(sl()));
    sl.registerLazySingleton(() => GetMoviesUseCase(sl()));
    sl.registerLazySingleton(() => SearchUseCase(sl()));
    sl.registerLazySingleton(() => GetRecentItemsUseCase(sl()));
    sl.registerLazySingleton(() => AddRecentItemUseCase(sl()));
    sl.registerLazySingleton(() => RemoveRecentItemUseCase(sl()));

    // Bloc
    sl.registerFactory(() => GenresBloc(sl()));
    sl.registerFactory(() => MoviesBloc(sl()));
    sl.registerFactory(() => MovieDetailsBloc(sl()));
    sl.registerFactory(() => SearchBloc(sl()));
    sl.registerFactory(() => RecentBloc(sl(), sl(), sl()));

    // sl.registerFactory(() => PopularMoviesBloc(sl()));
    // sl.registerFactory(() => TopRatedMoviesBloc(sl()));
    // sl.registerFactory(() => TVShowsBloc(sl()));
    // sl.registerFactory(() => TVShowDetailsBloc(sl(), sl()));
    // sl.registerFactory(() => PopularTVShowsBloc(sl()));
    // sl.registerFactory(() => TopRatedTVShowsBloc(sl()));
    // sl.registerFactory(() => RecentBloc(sl(), sl(), sl(), sl()));
  }
}
