part of 'search_bloc.dart';

enum SearchRequestStatus { empty, loading, loaded, error, noResults }

class SearchState extends Equatable {
  const SearchState({
    this.searching = '',
    this.searchResults = const [],
    this.status = SearchRequestStatus.empty,
    this.message = '',
  });

  final List<SearchResultItem> searchResults;
  final SearchRequestStatus status;
  final String message;
  final String searching;

  SearchState copyWith({
    List<SearchResultItem>? searchResults,
    SearchRequestStatus? status,
    String? message,
    String? searching,
  }) {
    return SearchState(
      searchResults: searchResults ?? this.searchResults,
      status: status ?? this.status,
      message: message ?? this.message,
      searching: searching ?? this.searching,
    );
  }

  @override
  List<Object> get props => [
        searchResults,
        status,
        message,
        searching,
      ];
}
