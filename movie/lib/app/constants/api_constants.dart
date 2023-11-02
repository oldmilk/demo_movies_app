import 'package:movie/app/constants/api_enums.dart';
import 'package:movie/app/constants/api_strings.dart';
import 'package:movie/app/entities/genre.dart';

class ApiConstants {
  static const String apiKey = '60c3f8820e02fcc4739484f0e814d9cf';
  static const String baseUrl = 'https://api.themoviedb.org/3';

  static const String baseBackdropUrl = 'https://image.tmdb.org/t/p/w1280';
  static const String basePosterUrl = 'https://image.tmdb.org/t/p/w500';
  static const String baseProfileUrl = 'https://image.tmdb.org/t/p/w300';
  static const String baseStillUrl = 'https://image.tmdb.org/t/p/w500';
  static const String baseAvatarUrl = 'https://image.tmdb.org/t/p/w185';
  static const String baseVideoUrl = 'https://www.youtube.com/watch?v=';

  static const String moviePlaceHolder =
      'https://davidkoepp.com/wp-content/themes/blankslate/images/Movie%20Placeholder.jpg';

  static const String castPlaceHolder =
      'https://palmbayprep.org/wp-content/uploads/2015/09/user-icon-placeholder.png';

  static const String avatarPlaceHolder =
      'https://cdn.pixabay.com/photo/2018/11/13/21/43/avatar-3814049__480.png';

  static const String stillPlaceHolder =
      'https://popcornsg.s3.amazonaws.com/gallery/1577405144-six-year.png';

  // movies paths

  static String getMoviesPath(
      {required int page,
      required List<Genre> genres,
      required SortBy sortBy}) {
    String withGenres = '';
    if (genres.isNotEmpty) {
      // &with_genres=$genresString
      withGenres = '&with_genres=${genres.join(',')}';
      withGenres = withGenres.toLowerCase();
    }

    int maxYear = DateTime.now().year + 1;
    int minYear = maxYear - 50;

// https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&primary_release_date.gte=2023-01-01&primary_release_date.lte=2024-12-31&sort_by=primary_release_date.desc&with_genres=action%2Canimation' \
// https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&primary_release_year.gte=1974-01-01&primary_release_year.lte=2024-12-31&sort_by=primary_release_date.desc&with_genres=animation
    String range =
        'primary_release_date.gte=$minYear-01-01&primary_release_date.lte=$maxYear-12-31';

    String sort = ApiStrings.primaryReleaseDateDesc; // default

    switch (sortBy) {
      case SortBy.primaryReleaseDateAsc:
        sort = ApiStrings.primaryReleaseDateAsc;
        break;

      case SortBy.primaryReleaseDateDesc:
        sort = ApiStrings.primaryReleaseDateDesc;
        break;
    }

    return '$baseUrl/discover/movie?api_key=$apiKey&include_adult=false&include_video=false&language=en-US&page=$page&$range&sort_by=$sort$withGenres';
  }

// https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=primary_release_date.desc&with_genres=Action%2CAnimation'

  // genres paths
  static String getGenresPath() {
    return '$baseUrl/genre/movie/list?api_key=$apiKey';
  }

  // search paths
  static String getSearchPath(String title) {
    return '$baseUrl/search/multi?api_key=$apiKey&include_adult=false&include_video=false&query=$title';
  }

  static String getMovieDetailsPath(int movieId) {
    return '$baseUrl/movie/$movieId?api_key=$apiKey&append_to_response=videos,credits,reviews,similar';
  }
}
