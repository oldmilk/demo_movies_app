import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:movie/app/presentation/pages/main_page.dart';
import 'package:movie/app/routes/app_routes.dart';
import 'package:movie/modules/genres/presentation/components/genres_filter_view.dart';
import 'package:movie/modules/movies/presentation/views/movie_details_view.dart';
import 'package:movie/modules/movies/presentation/views/movies_view.dart';
import 'package:movie/modules/search/presentation/views/search_view.dart';

const String moviesPath = '/movies';
const String movieDetailsPath = 'movieDetails/:movieId';
const String moviesGenresPath = 'genres';
const String searchPath = '/search';

class AppRouter {
  GoRouter router = GoRouter(
    initialLocation: moviesPath,
    routes: [
      ShellRoute(
        builder: (context, state, child) => MainPage(child: child),
        routes: [
          GoRoute(
            name: AppRoutes.moviesRoute,
            path: moviesPath,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: MoviesView(),
            ),
            routes: [
              GoRoute(
                name: AppRoutes.movieDetailsRoute,
                path: movieDetailsPath,
                pageBuilder: (context, state) => CupertinoPage(
                  child: MovieDetailsView(
                    movieId: int.parse(state.params['movieId']!),
                  ),
                ),
              ),
              GoRoute(
                name: AppRoutes.movieGenresRoute,
                path: moviesGenresPath,
                pageBuilder: (context, state) {
                  GenresFilterParameters params =
                      state.extra as GenresFilterParameters;

                  return NoTransitionPage(
                    child: GenresFilterView(params: params),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            name: AppRoutes.searchRoute,
            path: searchPath,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SearchView(),
            ),
          ),
        ],
      )
    ],
  );
}
