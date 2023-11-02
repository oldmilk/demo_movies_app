import 'package:movie/common/utils/functions.dart';
import 'package:movie/modules/search/data/models/search_result_item.dart';

class SearchResultItemModel extends SearchResultItem {
  const SearchResultItemModel({
    required super.tmdbID,
    required super.posterUrl,
    required super.title,
    required super.isMovie,
  });

  factory SearchResultItemModel.fromJson(Map<String, dynamic> json) {
    return SearchResultItemModel(
      tmdbID: json['id'],
      posterUrl: getPosterUrl(json['poster_path']),
      title: json['title'] ?? json['name'],
      isMovie: json['media_type'] == 'movie',
    );
  }
}
