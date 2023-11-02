import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
// import 'package:go_router/go_router.dart';
import 'package:movie/app/configs/app_colors.dart';
// import 'package:movie/app/configs/app_values.dart';
import 'package:movie/app/constants/api_enums.dart';
import 'package:movie/app/entities/genre.dart';
// import 'package:movie/app/constants/api_enums.dart';
// import 'package:movie/app/constants/api_strings.dart';
// import 'package:movie/app/constants/app_strings.dart';
// import 'package:go_router/go_router.dart';
// import 'package:movie/app/configs/app_values.dart';
// import 'package:movie/app/constants/app_strings.dart';
import 'package:movie/app/entities/media.dart';
// import 'package:movie/app/presentation/components/custom_slider.dart';
import 'package:movie/app/presentation/components/error_screen.dart';
import 'package:movie/app/presentation/components/loading_indicator.dart';
// import 'package:movie/app/presentation/components/section_header.dart';
// import 'package:movie/app/presentation/components/section_listview.dart';
// import 'package:movie/app/presentation/components/section_listview_card.dart';
// import 'package:movie/app/presentation/components/vertical_listview.dart';
// import 'package:movie/app/presentation/components/vertical_listview_card.dart';
import 'package:movie/app/presentation/components/vertical_pageview.dart';
import 'package:movie/app/presentation/components/vertical_pageview_card.dart';
import 'package:movie/app/routes/app_routes.dart';
// import 'package:movie/app/presentation/components/section_header.dart';
// import 'package:movie/app/presentation/components/section_listview.dart';
// import 'package:movie/app/presentation/components/section_listview_card.dart';
// import 'package:movie/app/presentation/components/slider_card.dart';
// import 'package:movie/app/routes/app_routes.dart';
// import 'package:movie/app/routes/app_routes.dart';
import 'package:movie/app/services/service_locator.dart';
import 'package:movie/common/utils/enums.dart';
import 'package:movie/modules/genres/presentation/components/genres_filter_view.dart';
import 'package:movie/modules/genres/presentation/controllers/genres_bloc/genres_bloc.dart';
import 'package:movie/modules/genres/presentation/controllers/genres_bloc/genres_event.dart';
import 'package:movie/modules/genres/presentation/controllers/genres_bloc/genres_state.dart';
import 'package:movie/modules/movies/presentation/controllers/movies_bloc/movies_bloc.dart';
import 'package:movie/modules/movies/presentation/controllers/movies_bloc/movies_event.dart';
import 'package:movie/modules/movies/presentation/controllers/movies_bloc/movies_state.dart';

class MoviesView extends StatelessWidget {
  const MoviesView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MoviesBloc>(
            create: (context) =>
                sl<MoviesBloc>()..add(const RefreshMoviesEvent())),
        BlocProvider<GenresBloc>(
            create: (context) => sl<GenresBloc>()..add(const GetGenresEvent())),
      ],
      child: BlocListener<GenresBloc, GenresState>(
        listener: (context, state) {
          if (state.genres.isNotEmpty) {
            context
                .read<MoviesBloc>()
                .add(ApplyGenresMoviesEvent(genres: state.selectedGenres));
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Movies By Genres"),
            backgroundColor: AppColors.primary,
            actions: <Widget>[
              BlocBuilder<GenresBloc, GenresState>(builder: (context, state) {
                return IconButton(
                    icon: const Icon(Icons.filter_alt),
                    onPressed: () async {
                      context.pushNamed(AppRoutes.movieGenresRoute,
                          extra: GenresFilterParameters(
                              genres: state.genres,
                              selectedGenres: state.selectedGenres,
                              addEvent: (List<Genre> list) {
                                context
                                    .read<GenresBloc>()
                                    .add(ApplyGenresEvent(genres: list));
                              }));
                    });
              }),
              // IconButton(icon: const Icon(Icons.filter_alt), onPressed: () {}),
              BlocBuilder<MoviesBloc, MoviesState>(
                builder: (context, state) {
                  switch (state.sortBy) {
                    case SortBy.primaryReleaseDateAsc:
                      return IconButton(
                          icon: const Icon(Icons.arrow_upward),
                          onPressed: () {
                            context.read<MoviesBloc>().add(
                                const SortMoviesEvent(
                                    sortBy: SortBy.primaryReleaseDateDesc));
                          });

                    case SortBy.primaryReleaseDateDesc:
                      return IconButton(
                          icon: const Icon(Icons.arrow_downward),
                          onPressed: () {
                            context.read<MoviesBloc>().add(
                                const SortMoviesEvent(
                                    sortBy: SortBy.primaryReleaseDateAsc));
                          });
                  }
                },
              ),
            ],
          ),
          body: BlocBuilder<MoviesBloc, MoviesState>(
            builder: (context, state) {
              switch (state.status) {
                case GetAllRequestStatus.loading:
                  return const LoadingIndicator();
                case GetAllRequestStatus.loaded:
                  return MoviesWidget(
                    movies: state.movies,
                  );
                case GetAllRequestStatus.error:
                case GetAllRequestStatus.fetchMoreError:
                  return ErrorScreen(
                    onTryAgainPressed: () {
                      context
                          .read<MoviesBloc>()
                          .add(const RefreshMoviesEvent());
                    },
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}

class MoviesWidget extends StatelessWidget {
  final List<Media> movies;

  const MoviesWidget({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return VerticalPageView(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        if (index < movies.length) {
          return VerticalPageViewCard(media: movies[index]);
        } else {
          return const LoadingIndicator();
        }
      },
      addEvent: () {
        context.read<MoviesBloc>().add(const FetchMoreMoviesEvent());
      },
    );
  }
}
